// worker.js
// Requisitos en el dashboard: 
// - D1 binding named "DB"
// - Secret named "JWT_SECRET"
// - Secret named "DISCORD_WEBHOOK"

const encoder = new TextEncoder();

// --------------------------
// 🔹 Helpers
// --------------------------
async function sha256hex(msg) {
    const b = encoder.encode(msg);
    const h = await crypto.subtle.digest("SHA-256", b);
    return Array.from(new Uint8Array(h))
        .map((x) => x.toString(16).padStart(2, "0"))
        .join("");
}
function randBase64(len = 12) {
    const arr = crypto.getRandomValues(new Uint8Array(len));
    let s = "";
    for (let b of arr) s += String.fromCharCode(b);
    return btoa(s);
}
async function signHMAC(secret, message) {
    const key = await crypto.subtle.importKey(
        "raw",
        new TextEncoder().encode(secret),
        { name: "HMAC", hash: "SHA-256" },
        false,
        ["sign"]
    );
    const sig = await crypto.subtle.sign("HMAC", key, new TextEncoder().encode(message));
    return Array.from(new Uint8Array(sig))
        .map((x) => x.toString(16).padStart(2, "0"))
        .join("");
}
function encodeBase64(obj) {
    return btoa(JSON.stringify(obj));
}
function decodeBase64ToObj(s) {
    try {
        return JSON.parse(atob(s));
    } catch {
        return null;
    }
}
async function createToken(secret, username, ttlSec = 60 * 60 * 24, role = "user") {
    const now = Math.floor(Date.now() / 1000);
    const payload = { u: username, iat: now, exp: now + ttlSec, role };
    const pl = encodeBase64(payload);
    const sig = await signHMAC(secret, pl);
    return `${pl}.${sig}`;
}
async function verifyToken(secret, token) {
    if (!token) return null;
    const parts = token.split(".");
    if (parts.length !== 2) return null;
    const [pl, sig] = parts;
    const expected = await signHMAC(secret, pl);
    if (expected !== sig) return null;
    const payload = decodeBase64ToObj(pl);
    if (!payload) return null;
    const now = Math.floor(Date.now() / 1000);
    if (payload.exp && payload.exp < now) return null;
    return payload;
}
function jsonResp(obj, status = 200) {
    const headers = {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type, Authorization",
    };
    return new Response(JSON.stringify(obj), { status, headers });
}

// --------------------------
// 🔹 Worker principal
// --------------------------
export default {
    async fetch(request, env) {
        const url = new URL(request.url);
        const path = url.pathname;
        const method = request.method.toUpperCase();

        // CORS
        if (method === "OPTIONS")
            return new Response(null, {
                headers: {
                    "Access-Control-Allow-Origin": "*",
                    "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",
                    "Access-Control-Allow-Headers": "Content-Type, Authorization",
                },
            });

        // Validación entorno
        if (!env.DB)
            return jsonResp(
                { error: "D1 binding not configured. Add D1 binding named DB in Worker settings." },
                500
            );
        if (!env.JWT_SECRET)
            return jsonResp(
                { error: "JWT_SECRET not set. Add secret named JWT_SECRET in Worker settings." },
                500
            );

        // helper para logs (solo update/delete y update_divisiones)
        async function writeOfficerLog(actor, action, target, details = null) {
            try {
                // he añadido 'update_divisiones' para que quede registrado al modificar divisiones
                if (action !== "update_officer" && action !== "delete_officer" && action !== "update_divisiones")
                    return;
                await env.DB.prepare(
                    "INSERT INTO logs (actor, action, target, details, created_at) VALUES (?, ?, ?, ?, datetime('now'))"
                )
                    .bind(actor, action, target, details)
                    .run();
            } catch (e) {
                console.error("log write error", e);
            }
        }

        // Validar token
        const authHeader = request.headers.get("Authorization") || "";
        const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : null;
        const payload = await verifyToken(env.JWT_SECRET, token);
        const username = payload ? payload.u : null;
        const userRole = payload ? payload.role : null;

        // --------------------------
        // 🔹 REGISTER
        // --------------------------
        if (path === "/api/register" && method === "POST") {
            try {
                const body = await request.json().catch(() => null);
                const uname = (body?.username || "").trim();
                const pwd = (body?.password || "").trim();
                if (!uname || !pwd)
                    return jsonResp({ error: "username and password required" }, 400);

                const exists = await env.DB.prepare("SELECT id FROM users WHERE username = ?")
                    .bind(uname)
                    .all();
                if (exists.results?.length)
                    return jsonResp({ error: "username already exists" }, 409);

                const salt = randBase64(12);
                const passHash = await sha256hex(salt + pwd);

                // Intentamos insertar la columna divisiones como '[]' por defecto (si existe la columna)
                try {
                    await env.DB.prepare(
                        "INSERT INTO users (username, password_hash, salt, role, divisiones) VALUES (?, ?, ?, ?, ?)"
                    )
                        .bind(uname, passHash, salt, "user", "[]")
                        .run();
                } catch (e) {
                    // Si la columna divisiones no existe, caemos a la inserción sin esa columna
                    await env.DB.prepare(
                        "INSERT INTO users (username, password_hash, salt, role) VALUES (?, ?, ?, ?)"
                    )
                        .bind(uname, passHash, salt, "user")
                        .run();
                }

                return jsonResp({ ok: true, message: "Usuario registrado correctamente." }, 201);
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // --------------------------
        // 🔹 LOGIN
        // --------------------------
        if (path === "/api/login" && method === "POST") {
            try {
                const body = await request.json().catch(() => null);
                if (!body?.username || !body?.password)
                    return jsonResp({ error: "username and password required" }, 400);

                // seleccionamos divisiones si existe
                const res = await env.DB.prepare(
                    "SELECT username, password_hash, salt, role, divisiones FROM users WHERE username = ?"
                )
                    .bind(body.username.trim())
                    .all();

                const row = res.results?.[0];
                if (!row) return jsonResp({ error: "invalid credentials" }, 401);

                const computed = await sha256hex(row.salt + body.password);
                if (computed !== row.password_hash)
                    return jsonResp({ error: "invalid credentials" }, 401);

                const tok = await createToken(env.JWT_SECRET, row.username, 86400, row.role || "user");

                // parse divisiones si viene en la DB
                let divisiones = [];
                try {
                    divisiones = row.divisiones ? JSON.parse(row.divisiones) : [];
                } catch {
                    divisiones = [];
                }

                return jsonResp({ token: tok, role: row.role, divisiones });
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // --------------------------
        // 🔹 Protección endpoints
        // --------------------------
        const protectedPrefixes = ["/api/officers", "/api/alert", "/api/users", "/api/logs", "/api/me", "/api/users/divisiones"];
        if (protectedPrefixes.some((p) => path.startsWith(p))) {
            if (!payload) return jsonResp({ error: "missing or invalid token" }, 401);
        }

        // /api/me -> devolvemos divisiones si existen
        if (path === "/api/me" && method === "GET") {
            try {
                const r = await env.DB.prepare("SELECT role, divisiones FROM users WHERE username = ?")
                    .bind(payload.u)
                    .all();
                const row = r.results?.[0] || {};
                let divisiones = [];
                try {
                    divisiones = row.divisiones ? JSON.parse(row.divisiones) : [];
                } catch {
                    divisiones = [];
                }
                return jsonResp({ user: payload.u, role: row.role || payload.role, divisiones });
            } catch (e) {
                return jsonResp({ user: payload.u, role: payload.role });
            }
        }

        // --------------------------
        // 🔹 OFFICERS
        // --------------------------

        // GET
        if (path === "/api/officers" && method === "GET") {
            try {
                const q = url.searchParams.get("search") || "";
                let rows;
                if (q) {
                    const pattern = `%${q}%`;
                    const r = await env.DB.prepare(
                        "SELECT id, officer_name, role, asignacion, division, created_at FROM officers WHERE officer_name LIKE ? OR role LIKE ? ORDER BY created_at DESC"
                    )
                        .bind(pattern, pattern)
                        .all();
                    rows = r.results || [];
                } else {
                    const r = await env.DB.prepare(
                        "SELECT id, officer_name, role, asignacion, division, created_at FROM officers ORDER BY created_at DESC"
                    ).all();
                    rows = r.results || [];
                }
                return jsonResp(rows);
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // CREATE
        if (path === "/api/officers" && method === "POST") {
            try {
                const body = await request.json().catch(() => null);
                const officer_name = (body?.officer_name || "").trim();
                const role = (body?.role || "").trim();
                const asignacion = (body?.asignacion || "").trim();
                const division = (body?.division || "").trim();

                if (!officer_name || !role)
                    return jsonResp({ error: "officer_name and role required" }, 400);
                if (!officer_name.includes("_"))
                    return jsonResp({ error: "officer_name must include _" }, 400);

                await env.DB.prepare(
                    "INSERT INTO officers (officer_name, role, asignacion, division, created_at) VALUES (?, ?, ?, ?, datetime('now'))"
                )
                    .bind(officer_name, role, asignacion, division)
                    .run();

                return jsonResp({ ok: true, message: "Oficial creado correctamente" }, 201);
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // UPDATE
        if (path.startsWith("/api/officers/") && (method === "PUT" || method === "PATCH")) {
            try {
                const id = path.split("/").pop();
                const body = await request.json().catch(() => null);
                const newRole = (body?.role || "").trim();
                const newAsign = (body?.asignacion || "").trim();
                const newDiv = (body?.division || "").trim();

                if (!newRole) return jsonResp({ error: "role required" }, 400);

                await env.DB.prepare(
                    "UPDATE officers SET role = ?, asignacion = ?, division = ? WHERE id = ?"
                )
                    .bind(newRole, newAsign, newDiv, id)
                    .run();

                const r = await env.DB.prepare("SELECT officer_name FROM officers WHERE id = ?")
                    .bind(id)
                    .all();
                const officer = r.results?.[0]?.officer_name || id;

                await writeOfficerLog(
                    username || "unknown",
                    "update_officer",
                    officer,
                    JSON.stringify({ newRole, newAsign, newDiv })
                );

                return jsonResp({ ok: true, message: "Oficial actualizado correctamente" });
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // DELETE
        if (path.startsWith("/api/officers/") && method === "DELETE") {
            try {
                const id = path.split("/").pop();
                const r = await env.DB.prepare("SELECT officer_name FROM officers WHERE id = ?")
                    .bind(id)
                    .all();
                const officer = r.results?.[0]?.officer_name || id;

                await env.DB.prepare("DELETE FROM officers WHERE id = ?").bind(id).run();
                await writeOfficerLog(username || "unknown", "delete_officer", officer, null);

                return jsonResp({ ok: true, message: "Oficial eliminado correctamente" });
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // --------------------------
        // 🔹 USERS
        // --------------------------
        if (path === "/api/users" && method === "GET") {
            const row = await env.DB.prepare("SELECT role FROM users WHERE username = ?")
                .bind(username)
                .all();
            const role = row.results?.[0]?.role || "user";
            if (role !== "admin") return jsonResp({ error: "admin only" }, 403);

            // traemos divisiones si existen en la DB
            const r = await env.DB.prepare(
                "SELECT id, username, role, divisiones, created_at FROM users ORDER BY created_at DESC"
            ).all();
            const results = (r.results || []).map((u) => {
                let divs = [];
                try {
                    divs = u.divisiones ? JSON.parse(u.divisiones) : [];
                } catch {
                    divs = [];
                }
                return { ...u, divisiones: divs };
            });
            return jsonResp(results || []);
        }

        if (path === "/api/users" && method === "POST") {
            const row = await env.DB.prepare("SELECT role FROM users WHERE username = ?")
                .bind(username)
                .all();
            const roleSelf = row.results?.[0]?.role || "user";
            if (roleSelf !== "admin") return jsonResp({ error: "admin only" }, 403);
            try {
                const body = await request.json().catch(() => null);
                const uname = (body?.username || "").trim();
                const pwd = (body?.password || "").trim();
                const roleNew = (body?.role || "user").trim();
                if (!uname || !pwd)
                    return jsonResp({ error: "username and password required" }, 400);
                const salt = randBase64(12);
                const passHash = await sha256hex(salt + pwd);

                // Intentar insertar con divisiones '[]' si la columna existe
                try {
                    await env.DB.prepare(
                        "INSERT INTO users (username, password_hash, salt, role, divisiones) VALUES (?, ?, ?, ?, ?)"
                    )
                        .bind(uname, passHash, salt, roleNew, "[]")
                        .run();
                } catch (e) {
                    await env.DB.prepare(
                        "INSERT INTO users (username, password_hash, salt, role) VALUES (?, ?, ?, ?)"
                    )
                        .bind(uname, passHash, salt, roleNew)
                        .run();
                }

                return jsonResp({ ok: true }, 201);
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // --------------------------
        // 🔹 USERS DIVISIONS (nuevo endpoint para actualizar divisiones de un usuario)
        // --------------------------
        if (path.startsWith("/api/users/divisiones/") && (method === "PUT" || method === "PATCH")) {
            try {
                const parts = path.split("/");
                const targetUser = parts.pop();
                if (!targetUser) return jsonResp({ error: "username required" }, 400);

                // comprobar que el que llama es admin
                const rSelf = await env.DB.prepare("SELECT role FROM users WHERE username = ?").bind(username).all();
                const myRole = rSelf.results?.[0]?.role || "user";
                if (myRole !== "admin") return jsonResp({ error: "admin only" }, 403);

                const body = await request.json().catch(() => null);
                const divisiones = body?.divisiones;
                if (!Array.isArray(divisiones)) return jsonResp({ error: "divisiones must be array" }, 400);
                if (divisiones.length > 5) return jsonResp({ error: "max 5 divisiones" }, 400);

                // limpiar duplicados y strings vacíos
                const clean = [...new Set(divisiones.map((d) => String(d).trim()).filter(Boolean))];

                // actualizar DB (si la columna divisiones no existe, dará error)
                try {
                    await env.DB.prepare("UPDATE users SET divisiones = ? WHERE username = ?")
                        .bind(JSON.stringify(clean), targetUser)
                        .run();
                } catch (e) {
                    return jsonResp({ error: "DB missing 'divisiones' column. Run ALTER TABLE users ADD COLUMN divisiones TEXT DEFAULT '[]'." }, 500);
                }

                // escribir log
                await writeOfficerLog(username || "unknown", "update_divisiones", targetUser, JSON.stringify(clean));

                return jsonResp({ ok: true, divisiones: clean });
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // --------------------------
        // 🔹 LOGS
        // --------------------------
        if (path === "/api/logs" && method === "GET") {
            const row = await env.DB.prepare("SELECT role FROM users WHERE username = ?")
                .bind(username)
                .all();
            const role = row.results?.[0]?.role || "user";
            if (role !== "admin") return jsonResp({ error: "admin only" }, 403);
            const q = url.searchParams.get("q") || "";
            let r;
            if (q) {
                const pattern = `%${q}%`;
                r = await env.DB.prepare(
                    "SELECT id, actor, action, target, details, created_at FROM logs WHERE actor LIKE ? OR action LIKE ? OR target LIKE ? ORDER BY created_at DESC"
                )
                    .bind(pattern, pattern, pattern)
                    .all();
            } else {
                r = await env.DB.prepare(
                    "SELECT id, actor, action, target, details, created_at FROM logs ORDER BY created_at DESC"
                ).all();
            }
            return jsonResp(r.results || []);
        }

        // --------------------------
        // 🔹 ALERT DISCORD
        // --------------------------
        if (path === "/api/alert" && method === "POST") {
            const webhook = env.DISCORD_WEBHOOK;
            if (!webhook)
                return jsonResp(
                    {
                        error: "DISCORD_WEBHOOK not configured. Add secret named DISCORD_WEBHOOK",
                    },
                    500
                );
            try {
                const body = await request.json().catch(() => null);
                const t = body?.type || "alert";
                const detail = body?.detail || "";
                const usernameAlert = payload.u || "unknown";
                const content = `🚨 **Anti-raid alert** 🚨\n**Usuario:** ${usernameAlert}\n**Tipo:** ${t}\n**Detalle:** ${detail}\n**Hora:** ${new Date().toISOString()}`;
                await fetch(webhook, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ content }),
                });
                return jsonResp({ ok: true });
            } catch (e) {
                return jsonResp({ error: e.message }, 500);
            }
        }

        // --------------------------
        // 🔹 DEFAULT
        // --------------------------
        return jsonResp({ error: "not found" }, 404);
    },
};
