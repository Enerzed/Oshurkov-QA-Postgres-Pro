WITH students_exams AS 
(
	SELECT * FROM "Students"
	LEFT JOIN "Exams" ON "Students"."s_id" = "Exams"."s_id"
)
SELECT students_exams."name" FROM students_exams
WHERE students_exams."score" IS NULL