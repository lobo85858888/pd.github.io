// script.js
const API_BASE = "https://dawn-bar-8e7d.aritztoquero123.workers.dev";

function saveToken(token) {
    localStorage.setItem("token", token);
}
function getToken() {
    return localStorage.getItem("token");
}
function logout() {
    localStorage.removeItem("token");
    window.location.href = "login.html";
}
function authHeaders() {
    return {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + getToken()
    };
}
async function checkAuth() {
    const t = getToken();
    if (!t) window.location.href = "login.html";
}

// Simple helpers
async function fetchJSON(url, opts = {}) {
    const res = await fetch(url, opts);
    return res.json();
}
