

CREATE TABLE "chats"(
  "id" BIGSERIAL PRIMARY KEY,
  "name" VARCHAR(128) NOT NULL CHECK("name"!=''),
  "ownerId" INT REFERENCES "users"("id"),
  "createdAt" TIMESTAMP NOT NULL DEFAULT current_timestamp
);
INSERT INTO "chats" ("name", "ownerId")
VALUES ('js', 2), ('tesla', 1), ('spaceX', 1);

--ссылается на первичные ключи
--имеет состовной первичный ключ
CREATE TABLE "users_to_chats"(
  "chatId" BIGINT REFERENCES "chats"("id"),
  "userId" INT REFERENCES "users"("id"),
  "createdAt" TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY ("chatId", "userId")
);
INSERT INTO "users_to_chats"("chatId", "userId")
VALUES (1,2),(1,1),(1,4),(2,3),(2,4),(2,1),(3,1),(3,3);

CREATE TABLE "messages"(
  "id" BIGSERIAL PRIMARY KEY,
  "body" VARCHAR(1024) NOT NULL CHECK("body"!=''),
  "userId" INT ,
  "chatId" BIGINT ,
  FOREIGN KEY ("chatId", "userId") REFERENCES "users_to_chats"("chatId", "userId")
);

INSERT INTO "messages"("body","chatId","userId")
VALUES ('hi',1,2),('hi!',1,2),('hi',1,2),('hi!!',1,1);