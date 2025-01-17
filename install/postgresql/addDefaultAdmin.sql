set search_path = sturatgacl;
INSERT INTO logingestion (id, login, password, nom, prenom, mail, datemodif, actif, is_clientws, tokenws, is_expired) VALUES (E'1', E'admin', E'cd916028a2d8a1b901e831246dd5b9b4d3832786ddc63bbf5af4b50d9fc98f50', E'Administrator', DEFAULT, E'admin@mysociety.com', E'2017-08-24 00:00:00', E'1', E'false', DEFAULT, E'false');
INSERT INTO acllogin (acllogin_id, login, logindetail) VALUES (E'1', E'admin', E'admin');
INSERT INTO acllogingroup (acllogin_id, aclgroup_id) VALUES (E'1', E'1');
INSERT INTO acllogingroup (acllogin_id, aclgroup_id) VALUES (E'1', E'4');
