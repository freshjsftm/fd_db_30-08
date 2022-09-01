CREATE TABLE "coaches"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(64)
);

CREATE TABLE "teames"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(64),
  "coachId" INT REFERENCES "coaches"("id")
);

ALTER TABLE "coaches"
ADD COLUMN "teamId" INT REFERENCES "teames"("id");

CREATE TABLE "test_node"("id" SERIAL PRIMARY KEY);