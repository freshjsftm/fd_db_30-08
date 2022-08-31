/*
DDL - CREATE, DROP
DML - INSERT
DQL - SELECT
TCL
DCL
*/
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS "products_to_orders";
DROP TABLE IF EXISTS "products";
DROP TABLE IF EXISTS "orders";
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
CREATE TABLE "orders" (
  "id" SERIAL PRIMARY KEY,--123
  "userId" INT REFERENCES "users"("id"), --4
  "createdAt" DATE NOT NULL CHECK("createdAt"<=current_date) DEFAULT current_date
);
CREATE TABLE "products" (
    "id" SERIAL PRIMARY KEY,
    "title" VARCHAR(256) NOT NULL CHECK("title"!=''), 
    "price" NUMERIC(5,2) NOT NULL CHECK("price">=0.01 AND "price"<=10000),
    "currency" VARCHAR(10) NOT NULL CHECK("currency"!=''),
    "productionDate" DATE NOT NULL, 
    "amount" NUMERIC(4,0) CHECK("amount">=0 AND "amount"<=1000),
    "expirationDate" VARCHAR(50),
    UNIQUE("title"),
    CONSTRAINT check_pr_date CHECK("productionDate"<current_date)
);
CREATE TABLE "products_to_orders"(
  "productId" INT REFERENCES "products"("id"), 
  "orderId" INT REFERENCES "orders"("id"),   
  "amount" INT CHECK("amount">0),     
  PRIMARY KEY ("productId", "orderId")
)








INSERT INTO "products"
VALUES ('bread', 12.5, 'UAH', '2022-05-30', 20, '1month'),
('milk', 30.5, 'UAH', '2022-06-30', 5, '3month'),
('meat', 100.55, 'UAH', '2022-07-22', 0, '2weeks'),
('sugar', 22.5, 'UAH', '2022-08-21', NULL, '1year'),
('eggs', 50, 'UAH', '2022-04-30', 300,  NULL);





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




INSERT INTO "users"("firstName","lastName","email","isMale","birthday","height")
VALUES ('Tom', 'Musk', 'elon@gmail.com', true, '1971-06-28', 1.88),
('Elen', 'Musk', 'musk1@gmail.com', false, '1971-06-28', 1.48),
('Elon', 'Musk', 'musk2@gmail.com', true, '1971-06-28', 1.84),
('Elon', 'Musk', 'musk3@gmail.com', false, '1971-06-28', 1.81);

ALTER TABLE "users"
DROP CONSTRAINT "users_email_key";

ALTER TABLE "users"
ADD UNIQUE("email");



