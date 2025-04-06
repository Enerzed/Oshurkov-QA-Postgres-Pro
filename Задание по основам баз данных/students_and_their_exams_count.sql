SELECT "Students"."name", COUNT("Exams"."s_id") FROM "Students"
JOIN "Exams" ON "Students"."s_id" = "Exams"."s_id"
GROUP BY "Students"."name"