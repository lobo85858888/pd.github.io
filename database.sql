PRAGMA defer_foreign_keys=TRUE;
CREATE TABLE officers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  officer_name TEXT NOT NULL,
  role TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, division TEXT, asignacion TEXT,
  CHECK (
    instr(officer_name, '_') > 1
  )
  -- exige al menos un '_' en el nombre
  
);
INSERT INTO "officers" VALUES(50,'Reymundo_Verdugo','Comandante en jefe','2025-10-31 18:54:53','Grupo De Mando','#00001');
INSERT INTO "officers" VALUES(51,'Joshua_Aleman','Comandante en jefe','2025-10-31 18:55:25','Grupo De Mando','#00002');
INSERT INTO "officers" VALUES(52,'Hatsune_Miku','Comisario General','2025-10-31 19:32:35','Grupo De Mando','#00003');
INSERT INTO "officers" VALUES(53,'Alejandro_Verdugo','Comisario General','2025-10-31 19:33:07','AIC','#00004');
INSERT INTO "officers" VALUES(54,'Oswaldo_Campos','Capitan','2025-10-31 19:33:42','AIC','#00005');
INSERT INTO "officers" VALUES(55,'Isabella_Redelfs','Teniente Primero','2025-10-31 19:34:56','','#00006');
INSERT INTO "officers" VALUES(56,'Carlos_Verdugo','Teniente Primero','2025-10-31 19:35:23','','#00007');
INSERT INTO "officers" VALUES(59,'Raymond_Callaghan','Teniente Primero','2025-10-31 19:37:14','','#00008');
INSERT INTO "officers" VALUES(60,'Kael_Draven','Capitan','2025-10-31 19:37:42','AIC','#00009');
INSERT INTO "officers" VALUES(61,'Harry_sokolov','Sub Teniente','2025-10-31 19:39:19','METRO','#00011');
INSERT INTO "officers" VALUES(62,'Luke_Howells','Sub Teniente','2025-10-31 19:39:52','Transito','#00012');
INSERT INTO "officers" VALUES(63,'Mac_Gomez','Capitan','2025-10-31 19:40:22','AIC','#00013');
INSERT INTO "officers" VALUES(64,'Alysha_Verstappen','Sargento Primero','2025-10-31 19:40:49','AIC','#00014');
INSERT INTO "officers" VALUES(65,'Giuseppe_Richeti','Sargento Primero','2025-10-31 19:41:06','AIC','#00015');
INSERT INTO "officers" VALUES(66,'Saya_Bellico','Capitan','2025-10-31 19:42:13','AIC','#00016');
INSERT INTO "officers" VALUES(68,'Wyatt_Collins','Sargento Segundo','2025-10-31 19:43:15','AIC','#00018');
INSERT INTO "officers" VALUES(69,'Hamza_Bozkurtlar','Sargento Segundo','2025-10-31 19:43:57','','#00019');
INSERT INTO "officers" VALUES(70,'Nolan_Pershing','Sargento Segundo','2025-10-31 19:44:17','AIC','#00020');
INSERT INTO "officers" VALUES(71,'Jazz_Wexler','Sargento Segundo','2025-10-31 19:44:47','','#00021');
INSERT INTO "officers" VALUES(72,'Dexter_Hardwell','Sargento Segundo','2025-10-31 19:45:38','Metro','#00022');
INSERT INTO "officers" VALUES(73,'Indra_Koval','Oficial I','2025-10-31 19:46:47','METRO','#00023');
INSERT INTO "officers" VALUES(74,'Jisus_Martinez','Oficial I','2025-10-31 19:51:40','','#00023');
INSERT INTO "officers" VALUES(75,'Micaela_Lambert','Oficial I','2025-10-31 19:52:05','DSA','#00024');
INSERT INTO "officers" VALUES(76,'Glock_Emma','Oficial I','2025-10-31 20:18:46','','#00025');
INSERT INTO "officers" VALUES(77,'Guido_Dal','Oficial I','2025-10-31 20:19:15','','#00026');
INSERT INTO "officers" VALUES(78,'Tayron_Sokolov','Oficial I','2025-10-31 20:20:13','Metro','#00026');
INSERT INTO "officers" VALUES(79,'Tokio_Shelbye','Oficial II','2025-10-31 20:21:16','','#00027');
INSERT INTO "officers" VALUES(80,'Dafne_Scott','Oficial II','2025-10-31 20:21:40','AIC','#00028');
INSERT INTO "officers" VALUES(81,'Jackson_bourns','Oficial II','2025-10-31 20:22:03','','#00029');
INSERT INTO "officers" VALUES(82,'Liam_Hardwell','Oficial II','2025-10-31 20:22:22','AIC','#00030');
INSERT INTO "officers" VALUES(83,'Kenny_Thompson','Oficial II','2025-10-31 22:04:08','AIC','#00031');
INSERT INTO "officers" VALUES(84,'Matthew_Greco','Oficial II','2025-10-31 22:04:34','','#00032');
INSERT INTO "officers" VALUES(85,'Noah_McGarret','Oficial II','2025-10-31 22:04:58','','#00033');
INSERT INTO "officers" VALUES(86,'Tycen_Brewer','Oficial II','2025-10-31 22:06:19','AIC','#00035');
INSERT INTO "officers" VALUES(87,'Sara_Denis','Oficial II','2025-10-31 22:06:53','','#00034');
INSERT INTO "officers" VALUES(88,'Steven_Power','Oficial II','2025-10-31 22:07:27','DSA','#00036');
INSERT INTO "officers" VALUES(89,'wilhem_Bittrich','Oficial II','2025-10-31 22:08:15','AIC','#00037');
INSERT INTO "officers" VALUES(90,'Adam_Parker','Oficial III','2025-10-31 22:08:54','AIC','#00038');
INSERT INTO "officers" VALUES(91,'Jaden_Jackson','Oficial III','2025-10-31 22:09:06','','#00039');
INSERT INTO "officers" VALUES(92,'Mashu_Boruni','Oficial III','2025-10-31 22:09:25','','#00040');
INSERT INTO "officers" VALUES(93,'Zephyr_Hardwell','Oficial III','2025-10-31 22:09:57','AIC','#00041');
INSERT INTO "officers" VALUES(94,'Aquiles_Young','Oficial III','2025-10-31 22:10:17','','#00042');
INSERT INTO "officers" VALUES(95,'Ariadna_Aniston','Oficial III','2025-10-31 22:11:03','','#00043');
INSERT INTO "officers" VALUES(97,'Dakota_Ashcroft','Oficial III','2025-10-31 22:11:59','','#00044');
INSERT INTO "officers" VALUES(98,'Deiwell_O''shea','Oficial III','2025-10-31 22:12:27','','#00046');
INSERT INTO "officers" VALUES(99,'Dreyvor_Xovian','Oficial III','2025-10-31 22:12:58','','#00047');
INSERT INTO "officers" VALUES(100,'Carlos_Rimon','Oficial III','2025-10-31 22:19:27','','#00045');
INSERT INTO "officers" VALUES(101,'Jean_Paul_Maxwell','Oficial III','2025-10-31 22:20:18','AIC','#00048');
INSERT INTO "officers" VALUES(102,'Jedrzejczyk_Lowhellz','Oficial III','2025-10-31 22:20:51','','#00049');
INSERT INTO "officers" VALUES(103,'Jose_Arenas','Oficial III','2025-10-31 22:21:08','','#00050');
INSERT INTO "officers" VALUES(104,'Marlo_Lightbourne','Oficial III','2025-10-31 22:23:57','','#00051');
INSERT INTO "officers" VALUES(105,'Matthew_Kleintonn','Oficial III','2025-10-31 22:25:46','','#00052');
INSERT INTO "officers" VALUES(106,'Melody_Corsck','Oficial III','2025-10-31 22:26:19','','#00053');
INSERT INTO "officers" VALUES(107,'Roberto_Baruzzo','Oficial III','2025-10-31 22:26:40','','#00054');
INSERT INTO "officers" VALUES(108,'Santiago_Menses','Oficial III','2025-10-31 22:26:58','','#00055');
INSERT INTO "officers" VALUES(109,'Stiffy_Toys','Oficial III','2025-10-31 22:27:27','','#00056');
INSERT INTO "officers" VALUES(110,'Taylor_Muhammad','Oficial III','2025-10-31 22:27:55','','#00057');
INSERT INTO "officers" VALUES(111,'Versot''n_Matthaus','Oficial III','2025-10-31 22:28:15','','#00058');
INSERT INTO "officers" VALUES(112,'Yenner_Feliz','Oficial III','2025-10-31 22:30:04','','#00059');
INSERT INTO "officers" VALUES(113,'Zachary_Wright','Oficial III','2025-10-31 22:30:31','','#00060');
INSERT INTO "officers" VALUES(115,'Omar_Courtz','Teniente Primero','2025-11-02 01:37:07','Metro','#00010');
INSERT INTO "officers" VALUES(116,'Isaac_Sledge','Sargento Primero','2025-11-02 02:32:29','AIC','#00022');
CREATE TABLE logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  actor TEXT,        -- username que hizo la acción
  action TEXT,       -- 'create','update','delete','login', etc.
  target TEXT,       -- objetivo: officer_name o user, etc.
  details TEXT,      -- JSON o descripción
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "logs" VALUES(1,'lobo8585888','register',NULL,NULL,'2025-10-31 17:09:30');
INSERT INTO "logs" VALUES(2,'lobo8585888','login',NULL,'{"ip":"62.99.106.69"}','2025-10-31 17:09:37');
INSERT INTO "logs" VALUES(3,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:31');
INSERT INTO "logs" VALUES(4,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:33');
INSERT INTO "logs" VALUES(5,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:35');
INSERT INTO "logs" VALUES(6,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:37');
INSERT INTO "logs" VALUES(7,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:39');
INSERT INTO "logs" VALUES(8,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:41');
INSERT INTO "logs" VALUES(9,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:43');
INSERT INTO "logs" VALUES(10,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:45');
INSERT INTO "logs" VALUES(11,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:48');
INSERT INTO "logs" VALUES(12,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:50');
INSERT INTO "logs" VALUES(13,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:52');
INSERT INTO "logs" VALUES(14,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:54');
INSERT INTO "logs" VALUES(15,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:56');
INSERT INTO "logs" VALUES(16,'lobo8585888','create_officer','hola_1','{"role":"hola_1"}','2025-10-31 17:12:59');
INSERT INTO "logs" VALUES(17,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:13:01');
INSERT INTO "logs" VALUES(18,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:13:03');
INSERT INTO "logs" VALUES(19,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:13:05');
INSERT INTO "logs" VALUES(20,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:14:43');
INSERT INTO "logs" VALUES(21,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:14:45');
INSERT INTO "logs" VALUES(22,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:14:48');
INSERT INTO "logs" VALUES(23,'lobo8585888','login_fail',NULL,'{"ip":"62.99.106.69"}','2025-10-31 17:15:31');
INSERT INTO "logs" VALUES(24,'lobo8585888','login',NULL,'{"ip":"62.99.106.69"}','2025-10-31 17:15:37');
INSERT INTO "logs" VALUES(25,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:18:15');
INSERT INTO "logs" VALUES(26,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:18:19');
INSERT INTO "logs" VALUES(27,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:18:21');
INSERT INTO "logs" VALUES(28,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:20:02');
INSERT INTO "logs" VALUES(29,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:20:05');
INSERT INTO "logs" VALUES(30,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:20:06');
INSERT INTO "logs" VALUES(31,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:22:32');
INSERT INTO "logs" VALUES(32,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:22:34');
INSERT INTO "logs" VALUES(33,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 17:23:15');
INSERT INTO "logs" VALUES(34,'lobo8585888','delete_officer','hola_121',NULL,'2025-10-31 17:23:35');
INSERT INTO "logs" VALUES(35,'lobo8585888','update_officer','Saya_Bellico','{"newRole":"Capitan"}','2025-10-31 18:05:58');
INSERT INTO "logs" VALUES(36,'lobo8585888','update_officer','Saya_Bellico','{"newRole":"Sargento Primero"}','2025-10-31 18:06:04');
INSERT INTO "logs" VALUES(37,'lobo8585888','update_officer','Jazz_Wexler','{"newRole":"Sargento Segundo"}','2025-10-31 18:07:47');
INSERT INTO "logs" VALUES(38,'intoxicado','update_officer','Tycen_Brewer','{"newRole":"Oficial lI"}','2025-10-31 18:15:16');
INSERT INTO "logs" VALUES(39,'intoxicado','update_officer','Tycen_Brewer','{"newRole":"Oficial II"}','2025-10-31 18:15:26');
INSERT INTO "logs" VALUES(40,'lobo8585888','delete_officer','Tycen_Brewer',NULL,'2025-10-31 18:24:27');
INSERT INTO "logs" VALUES(41,'lobo8585888','delete_officer','Reymundo_Verdugo',NULL,'2025-10-31 18:25:52');
INSERT INTO "logs" VALUES(42,'lobo8585888','update_officer','Reymundo_Verdugo','{"newRole":"Comandante en jefe"}','2025-10-31 18:26:06');
INSERT INTO "logs" VALUES(43,'lobo8585888','update_officer','Reymundo_Verdugo','{"newRole":"Comandante en jefe"}','2025-10-31 18:26:13');
INSERT INTO "logs" VALUES(44,'lobo8585888','delete_officer','Reymundo_Verdugo',NULL,'2025-10-31 18:30:20');
INSERT INTO "logs" VALUES(45,'lobo8585888','delete_officer','Reymundo_Verdugo',NULL,'2025-10-31 18:32:21');
INSERT INTO "logs" VALUES(46,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:32:23');
INSERT INTO "logs" VALUES(47,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:35:39');
INSERT INTO "logs" VALUES(48,'lobo8585888','delete_officer','Reymundo_Verdugo',NULL,'2025-10-31 18:35:41');
INSERT INTO "logs" VALUES(49,'lobo8585888','delete_officer','Reymundo_Verdugo',NULL,'2025-10-31 18:35:43');
INSERT INTO "logs" VALUES(50,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:35:45');
INSERT INTO "logs" VALUES(51,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:35:50');
INSERT INTO "logs" VALUES(52,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:38:21');
INSERT INTO "logs" VALUES(53,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:38:23');
INSERT INTO "logs" VALUES(54,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:38:25');
INSERT INTO "logs" VALUES(55,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:38:30');
INSERT INTO "logs" VALUES(56,'lobo8585888','delete_officer','42',NULL,'2025-10-31 18:38:30');
INSERT INTO "logs" VALUES(57,'lobo8585888','delete_officer','1_1',NULL,'2025-10-31 18:38:33');
INSERT INTO "logs" VALUES(58,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:42:21');
INSERT INTO "logs" VALUES(59,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:42:23');
INSERT INTO "logs" VALUES(60,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:42:24');
INSERT INTO "logs" VALUES(61,'lobo8585888','delete_officer','hola_1',NULL,'2025-10-31 18:51:33');
INSERT INTO "logs" VALUES(62,'lobo8585888','update_officer','Joshua_Aleman','{"newRole":"Comandante en jefe","newAsign":"#00002","newDiv":"Grupo De Mando"}','2025-10-31 19:01:28');
INSERT INTO "logs" VALUES(63,'intoxicado','update_officer','Alejandro_Verdugo','{"newRole":"Capitan","newAsign":"#00004","newDiv":"AIC"}','2025-10-31 19:33:31');
INSERT INTO "logs" VALUES(64,'intoxicado','delete_officer','Kael_Draven',NULL,'2025-10-31 19:36:35');
INSERT INTO "logs" VALUES(65,'intoxicado','update_officer','Harry_sokolov','{"newRole":"Sub Teniente","newAsign":"#00011","newDiv":"METRO"}','2025-10-31 19:39:29');
INSERT INTO "logs" VALUES(66,'intoxicado','update_officer','Tycen_Brewer','{"newRole":"Oficial II","newAsign":"#00035","newDiv":"AIC"}','2025-10-31 22:07:02');
INSERT INTO "logs" VALUES(67,'intoxicado','delete_officer','Carlos_Rimon',NULL,'2025-10-31 22:13:35');
INSERT INTO "logs" VALUES(68,'intoxicado','update_officer','Dakota_Ashcroft','{"newRole":"Oficial III","newAsign":"#00044","newDiv":""}','2025-10-31 22:13:39');
INSERT INTO "logs" VALUES(69,'lobo8585888','update_officer','Saya_Bellico','{"newRole":"Capitan","newAsign":"#00016","newDiv":"AIC"}','2025-10-31 22:17:35');
INSERT INTO "logs" VALUES(70,'lobo8585888','update_officer','Alejandro_Verdugo','{"newRole":"Comisario","newAsign":"#00004","newDiv":"AIC"}','2025-10-31 22:21:01');
INSERT INTO "logs" VALUES(71,'intoxicado','update_officer','Alejandro_Verdugo','{"newRole":"Comisario","newAsign":"#00004","newDiv":"AIC"}','2025-10-31 22:24:05');
INSERT INTO "logs" VALUES(72,'intoxicado','update_officer','Alejandro_Verdugo','{"newRole":"Comisario General","newAsign":"#00004","newDiv":"AIC"}','2025-10-31 22:28:27');
INSERT INTO "logs" VALUES(73,'intoxicado','update_officer','Mac_Gomez','{"newRole":"Capitan","newAsign":"#00013","newDiv":"AIC"}','2025-10-31 22:32:57');
INSERT INTO "logs" VALUES(74,'lobo8585888','update_officer','Dexter_Hardwell','{"newRole":"Sargento Segundo","newAsign":"#00022","newDiv":"Metro"}','2025-10-31 22:54:29');
INSERT INTO "logs" VALUES(75,'lobo8585888','update_divisiones','lobo8585888','["AIC","super"]','2025-11-01 20:12:07');
INSERT INTO "logs" VALUES(76,'intoxicado','update_divisiones','intoxicado','["FTO"]','2025-11-01 20:34:47');
INSERT INTO "logs" VALUES(77,'intoxicado','update_divisiones','intoxicado','[]','2025-11-01 20:35:18');
INSERT INTO "logs" VALUES(78,'lobo8585888','update_divisiones','Verdugo','["super"]','2025-11-01 20:39:20');
INSERT INTO "logs" VALUES(79,'lobo8585888','update_divisiones','intoxicado','["FTO"]','2025-11-01 20:40:48');
INSERT INTO "logs" VALUES(80,'lobo8585888','update_divisiones','jefe','["FTO"]','2025-11-01 20:42:34');
INSERT INTO "logs" VALUES(81,'lobo8585888','update_divisiones','jefe','["fto"]','2025-11-01 20:45:11');
INSERT INTO "logs" VALUES(82,'lobo8585888','update_divisiones','jefe','["super"]','2025-11-01 20:46:52');
INSERT INTO "logs" VALUES(83,'lobo8585888','update_divisiones','jefe','["super","FTO"]','2025-11-01 20:47:42');
INSERT INTO "logs" VALUES(84,'lobo8585888','update_divisiones','jefe','[]','2025-11-01 20:48:59');
INSERT INTO "logs" VALUES(85,'lobo8585888','update_divisiones','intoxicado','["super"]','2025-11-01 20:49:10');
INSERT INTO "logs" VALUES(86,'lobo8585888','update_divisiones','intoxicado','["super","AIC"]','2025-11-01 20:49:31');
INSERT INTO "logs" VALUES(87,'lobo8585888','update_divisiones','intoxicado','["AIC","super"]','2025-11-01 20:50:39');
INSERT INTO "logs" VALUES(88,'lobo8585888','update_divisiones','jefe','["AIC","super"]','2025-11-01 20:51:21');
INSERT INTO "logs" VALUES(89,'lobo8585888','update_divisiones','lobo8585888','["AIC","super"]','2025-11-01 21:00:16');
INSERT INTO "logs" VALUES(90,'lobo8585888','update_divisiones','lobo8585888','["AIC","super"]','2025-11-01 21:02:38');
INSERT INTO "logs" VALUES(91,'lobo8585888','update_divisiones','lobo8585888','["AIC","super"]','2025-11-01 21:05:22');
INSERT INTO "logs" VALUES(92,'lobo8585888','update_divisiones','lobo8585888','["super"]','2025-11-01 21:16:29');
INSERT INTO "logs" VALUES(93,'lobo8585888','update_divisiones','lobo8585888','["FTO"]','2025-11-01 21:17:17');
INSERT INTO "logs" VALUES(94,'lobo8585888','update_divisiones','lobo8585888','["SUPER"]','2025-11-01 21:18:15');
INSERT INTO "logs" VALUES(95,'lobo8585888','update_divisiones','lobo8585888','["AIC"]','2025-11-01 21:19:22');
INSERT INTO "logs" VALUES(96,'lobo8585888','update_divisiones','lobo8585888','[]','2025-11-01 21:19:38');
INSERT INTO "logs" VALUES(97,'lobo8585888','update_divisiones','lobo8585888','["super"]','2025-11-01 21:21:00');
INSERT INTO "logs" VALUES(98,'lobo8585888','update_divisiones','lobo8585888','["super","AIC"]','2025-11-01 21:23:15');
INSERT INTO "logs" VALUES(99,'lobo8585888','update_divisiones','lobo8585888','["super","FTO"]','2025-11-01 21:25:43');
INSERT INTO "logs" VALUES(100,'lobo8585888','update_divisiones','lobo8585888','["FTO"]','2025-11-01 21:26:00');
INSERT INTO "logs" VALUES(101,'lobo8585888','update_divisiones','lobo8585888','["super"]','2025-11-01 21:26:29');
INSERT INTO "logs" VALUES(102,'lobo8585888','update_divisiones','lobo8585888','["aic"]','2025-11-01 21:28:54');
INSERT INTO "logs" VALUES(103,'lobo8585888','update_divisiones','lobo8585888','["super"]','2025-11-01 21:29:41');
INSERT INTO "logs" VALUES(104,'lobo8585888','update_divisiones','lobo8585888','["DSA"]','2025-11-01 21:36:51');
INSERT INTO "logs" VALUES(105,'lobo8585888','update_divisiones','lobo8585888','["super"]','2025-11-01 21:40:35');
INSERT INTO "logs" VALUES(106,'lobo8585888','delete_officer','Omar_Courtz',NULL,'2025-11-01 22:58:05');
INSERT INTO "logs" VALUES(107,'lobo8585888','update_divisiones','Verdugo6','["super"]','2025-11-01 23:04:27');
INSERT INTO "logs" VALUES(108,'lobo8585888','update_officer','Dexter_Hardwell','{"newRole":"Sargento Segundo","newAsign":"#00022","newDiv":"FTO"}','2025-11-01 23:23:44');
INSERT INTO "logs" VALUES(109,'lobo8585888','update_officer','Dexter_Hardwell','{"newRole":"Sargento Segundo","newAsign":"#00022","newDiv":"Metro"}','2025-11-01 23:23:50');
INSERT INTO "logs" VALUES(110,'lobo8585888','update_divisiones','KrazZpZ','["AIC","FTO","Transito"]','2025-11-02 00:26:14');
INSERT INTO "logs" VALUES(111,'intoxicado','update_officer','Omar_Court','{"newRole":"Capitan","newAsign":"#00010","newDiv":"Metro"}','2025-11-02 00:34:31');
INSERT INTO "logs" VALUES(112,'intoxicado','update_officer','Kael_Draven','{"newRole":"Capitan","newAsign":"#00009","newDiv":"AIC"}','2025-11-02 00:34:39');
INSERT INTO "logs" VALUES(113,'lobo8585888','update_divisiones','Dazzleh','["Metro"]','2025-11-02 00:35:47');
INSERT INTO "logs" VALUES(114,'lobo8585888','update_divisiones','lobo8585888','["metro"]','2025-11-02 00:35:55');
INSERT INTO "logs" VALUES(115,'lobo8585888','delete_officer','Omar_Court',NULL,'2025-11-02 01:36:11');
INSERT INTO "logs" VALUES(116,'Verdugo6','delete_officer','Isacc_Seldge',NULL,'2025-11-02 02:35:27');
INSERT INTO "logs" VALUES(117,'lobo8585888','update_divisiones','lobo8585888','["super"]','2025-11-02 09:47:38');
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL, -- SHA-256(salt + password) en hex
  salt TEXT NOT NULL,          -- salt en base64
  role TEXT NOT NULL DEFAULT 'user', -- 'admin' o 'user'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
, divisiones TEXT DEFAULT '[]');
INSERT INTO "users" VALUES(1,'lobo8585888','a13398726a78d5abf64f4b139db8aecfeb94c6d4cca9a41b26c2489ec63245c9','U+ivqygtqnqzQZPq','admin','2025-10-31 17:09:29','["super"]');
INSERT INTO "users" VALUES(3,'intoxicado','c67c7f8f7c056189ecc97c67062d63d50bf04c479258f2d3187f843b3f4fdb4a','Pm13ByzNBacJjWuJ','admin','2025-10-31 18:12:54','["AIC","super"]');
INSERT INTO "users" VALUES(5,'JODIDOBRIII','fa0ff754da312a52ab544dd9889201282640b83b2359f99237670a0df8a7145c','IZH+T3cSqzYxiCYv','admin','2025-11-01 11:43:51','["AIC","super"]');
INSERT INTO "users" VALUES(7,'jefe','5fab5c67be8ce9c5ec24e10629201de1cafbbe57f1cabe5a8d7b6e62d2e1987d','jQuvs2dLNGNYaFLR','user','2025-11-01 20:52:47','[]');
INSERT INTO "users" VALUES(8,'Alejandro verdugo','5ca685b96e7c921562e6705f78f369aee1a3e312ee8c498499b97b06c25ba0cf','j/shbIXj9tn85waT','user','2025-11-01 21:44:11','["super"]');
INSERT INTO "users" VALUES(9,'Dazzleh','6593fc50fd24be15cd40d5fed16c573f2d2451bbcbf4adf1ee6a43387885d6b9','ajWBbcFY6WsC07pd','user','2025-11-01 22:42:16','["Metro"]');
INSERT INTO "users" VALUES(10,'DarkCOL','dd72601ce8cdf428faf458a5a12ec50d97ba3932a636d963c0e86207de1b8323','QuzRUVvmqPAD4TXA','user','2025-11-01 22:42:21','[]');
INSERT INTO "users" VALUES(11,'Mashu','8b14747e2cf2334f7f79943b391ff31a1b3929303aded142809dd6cf74df137f','Zc6xAHCNw+lpK9in','user','2025-11-01 22:42:22','[]');
INSERT INTO "users" VALUES(12,'Match2022','b50dc24f817f9d48de2e3b5ca1fb6be3ac8b0ad06073c49ea9a5cf6eadd1a812','kR46m2ng0qPgq25y','user','2025-11-01 22:42:23','[]');
INSERT INTO "users" VALUES(13,'KrazZpZ','c7a05c20308f5695b494d5f9000ee6fb131f2d0e1e55c483d33c137d1c99b7e7','pWk/ZKJ8QWqD3bQD','admin','2025-11-01 22:43:48','["AIC","FTO","Transito"]');
INSERT INTO "users" VALUES(14,'Verdugo6','4582a4eedd0a524c27a30790b7a92e057f66f6969f9c85541c450b7eb8918d14','LgpH6fRlAQ1Zrir8','admin','2025-11-01 23:03:45','["super"]');
INSERT INTO "users" VALUES(15,'Klovz','b43c84bdf20c4144633c964393ce75eedf4abcad4ab72f961d064b97743f7ad6','kWeislJaDQS64Ai/','user','2025-11-02 02:21:51','[]');
INSERT INTO "users" VALUES(16,'hazam','d0cb19f76015ff53a3bb011bbc305358fe3316864c49f969f5c040e14d82900f','w/GuyyEBWV5fGEeo','user','2025-11-02 02:31:50','[]');
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('officers',116);
INSERT INTO "sqlite_sequence" VALUES('users',16);
INSERT INTO "sqlite_sequence" VALUES('logs',117);
