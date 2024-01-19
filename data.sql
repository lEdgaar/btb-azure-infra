INSERT INTO ROLE_TYPE(role_name, role_code) VALUES('Broker', 'B');
INSERT INTO ROLE_TYPE(role_name, role_code) VALUES('Admin', 'A');
INSERT INTO ROLE_TYPE(role_name, role_code) VALUES('Organization', 'O');
INSERT INTO ROLE_TYPE(role_name, role_code) VALUES('Admin Group', 'AG');


INSERT INTO `btb_db`.`membership_types` (`id`, `name`, `internal_code`) VALUES ('2', 'ADMIN', 'A');
INSERT INTO `btb_db`.`membership_types` (`id`, `name`, `internal_code`) VALUES ('3', 'Member', 'M');
INSERT INTO `btb_db`.`asset_groups` (`name`, `description`, `is_enabled`) VALUES ('Materias Primas', 'Materias Primas', '2');
INSERT INTO `btb_db`.`assets` (`name`, `market_code`, `data_source`, `asset_groups_id`, `is_enabled`) VALUES ('Oro', 'OANDA', 'trading', '1', '1');





ALTER TABLE `GROUPS` ADD COLUMN TITLE VARCHAR(50);
ALTER TABLE `GROUPS` ADD COLUMN CREATED_AT DATE;
ALTER TABLE `GROUPS` ADD COLUMN MODIFIED_AT DATE;
ALTER TABLE `GROUPS` ADD COLUMN IS_DELETED BOOLEAN;
ALTER TABLE `GROUPS` ADD COLUMN DELETED_AT DATE;

INSERT INTO EVENT_TYPES(name, internal_code) VALUES('USERS AND ORGANIZATIONS SERVICE', 'UOS');
INSERT INTO EVENT_TYPES(name, internal_code) VALUES('BRIEFCASE SERVICE', 'BS');
INSERT INTO EVENT_TYPES(name, internal_code) VALUES('TRANSACTIONS SERVICE', 'TS');
INSERT INTO EVENT_TYPES(name, internal_code) VALUES('NOTIFICATION SERVICE', 'NCS');
INSERT INTO EVENT_TYPES(name, internal_code) VALUES('GROUPS SERVICE', 'GS');
INSERT INTO EVENT_TYPES(name, internal_code) VALUES('SECURITY SERVICE', 'SS');
INSERT INTO EVENT_TYPES(name, internal_code) VALUES('REPORTS SERVICE', 'RS');

INSERT INTO ban_reasons(reason, is_visible) VALUES('MALA CONDUCTA', 1);
INSERT INTO ban_reasons(reason, is_visible) VALUES('FALTAS DE RESPETO', 1);
INSERT INTO ban_reasons(reason, is_visible) VALUES('NO CUMPLE LA ACUERDO LEGAL', 1);
INSERT INTO ban_reasons(reason, is_visible) VALUES('MAL USO DE LA PLATAFORMA', 1);
