-- SENTRY-327
ALTER TABLE SENTRY_DB_PRIVILEGE ADD WITH_GRANT_OPTION CHAR(1) NOT NULL;

-- SENTRY-339
DROP INDEX SENTRYPRIVILEGENAME;
CREATE UNIQUE INDEX SENTRYPRIVILEGENAME ON SENTRY_DB_PRIVILEGE ("SERVER_NAME",DB_NAME,"TABLE_NAME",URI,"ACTION",WITH_GRANT_OPTION);
ALTER TABLE SENTRY_DB_PRIVILEGE DROP PRIVILEGE_NAME;

-- SENTRY-380
ALTER TABLE `SENTRY_DB_PRIVILEGE` DROP `GRANTOR_PRINCIPAL`;
ALTER TABLE `SENTRY_ROLE` DROP `GRANTOR_PRINCIPAL`;
ALTER TABLE `SENTRY_GROUP` DROP `GRANTOR_PRINCIPAL`;

ALTER TABLE `SENTRY_ROLE_DB_PRIVILEGE_MAP` ADD `GRANTOR_PRINCIPAL` VARCHAR(128);
ALTER TABLE `SENTRY_ROLE_GROUP_MAP` ADD `GRANTOR_PRINCIPAL` VARCHAR(128);

-- Version update
UPDATE SENTRY_VERSION SET SCHEMA_VERSION='1.4.0-cdh5', VERSION_COMMENT='Sentry release version 1.4.0-cdh5' WHERE VER_ID=1;
