/*
DDL - CREATE, DROP
DML - INSERT
DQL - SELECT
TCL
DCL
*/
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS "products_to_orders";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "products";
DROP TABLE IF EXISTS "users";

CREATE TABLE "users"(
  "id" SERIAL PRIMARY KEY,
  "firstName" VARCHAR(32) NOT NULL CHECK("firstName"!=''),
  "lastName" VARCHAR(32) NOT NULL CHECK("lastName"!=''),
  "email" VARCHAR(256) NOT NULL UNIQUE CHECK("email"!=''),
  "isMale" BOOLEAN NOT NULL,
  "birthday" DATE NOT NULL CHECK("birthday"<current_date),
  "height" NUMERIC(3,2) NOT NULL CHECK("height">=1.1 AND "height"<=2.5)
);
CREATE TABLE "products" (
    "id" SERIAL PRIMARY KEY,
    "title" VARCHAR(256) NOT NULL CHECK("title"!='') UNIQUE, 
    "price" NUMERIC(5,2) NOT NULL CHECK("price">=0.01 AND "price"<=10000),
    "currency" VARCHAR(10) NOT NULL CHECK("currency"!=''),
    "productionDate" DATE NOT NULL CHECK("productionDate"<current_date), 
    "amount" NUMERIC(4,0) CHECK("amount">=0 AND "amount"<=1000),
    "expirationDate" VARCHAR(50)
);
CREATE TABLE "orders" (
  "id" SERIAL PRIMARY KEY,
  "userId" INT REFERENCES "users"("id"),
  "createdAt" DATE NOT NULL CHECK("createdAt"<=current_date) DEFAULT current_date
);
CREATE TABLE "products_to_orders"(
  "productId" INT REFERENCES "products"("id"), 
  "orderId" INT REFERENCES "orders"("id"),   
  "quantity" INT CHECK("quantity">0),     
  PRIMARY KEY ("productId", "orderId")
)

INSERT INTO "users"("firstName","lastName","email","isMale","birthday","height")
VALUES ('Rob', 'Bob', 'elon4@gmail.com', true, '1971-06-28', 1.88),
('Fred', 'Bred', 'musk15@gmail.com', false, '1971-06-28', 1.48);

INSERT INTO "products" ("title","price","currency","productionDate","amount")
VALUES ('milk',32,'uh','2022-01-01',100),
('egg',32,'uh','2022-01-01',100),
('bread',13,'uh','2022-01-01',100),
('qwerty',302,'uh','2022-01-01',100);

INSERT INTO "orders"("userId") VALUES (1),(2),(1);

INSERT INTO products_to_orders ("orderId", "productId", "quantity")
VALUES (1,2,10),
(1,1,1),
(1,3,1),
(2,3,5),
(3,4,20),
(3,2,10);







DROP TABLE "messages";
CREATE TABLE "messages"(
  "id" SERIAL PRIMARY KEY,
  "body" VARCHAR(2048) NOT NULL CHECK("body"!=''), 
  "author" VARCHAR(256) NOT NULL CHECK("author"!='') DEFAULT 'anonim', 
  "isReady" BOOLEAN NOT NULL DEFAULT FALSE, 
  "createdAt" TIMESTAMP NOT NULL CHECK("createdAt"<=current_timestamp) DEFAULT current_timestamp
);

INSERT INTO "messages"("author","body")
VALUES ('Elon Musk','hi');

ALTER TABLE "users"
DROP CONSTRAINT "users_email_key";

ALTER TABLE "users"
ADD UNIQUE("email");



