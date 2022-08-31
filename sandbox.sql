DROP TABLE "a";
CREATE TABLE "a"(
  "b" INT,
  "c" INT,
  PRIMARY KEY("b","c")
);
INSERT INTO "a"
VALUES (1,1), (1,1), (2,1), (1,2); 