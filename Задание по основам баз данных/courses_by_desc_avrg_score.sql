WITH courses_exams AS
(
	SELECT "Courses"."title" AS title, AVG("Exams"."score") AS avrg FROM "Courses"
	JOIN "Exams" ON "Exams"."c_id" = "Courses"."c_id"
	GROUP BY "Courses"."title"
)
SELECT title, avrg from courses_exams
ORDER BY avrg DESC