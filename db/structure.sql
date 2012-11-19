CREATE TABLE "accounts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "password_digest" varchar(255), "salt" varchar(255), "token" varchar(255), "account_type" varchar(255), "active" boolean DEFAULT 'f', "activated_at" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "persons" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "firstname" varchar(255), "lastname" varchar(255), "surname" varchar(255), "date" date, "city" varchar(255), "phone" integer, "about_me" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20121018140909');

INSERT INTO schema_migrations (version) VALUES ('20121106134107');

INSERT INTO schema_migrations (version) VALUES ('20121106140003');