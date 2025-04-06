WITH new_students AS 
(
	-- Insert values into students table --
	INSERT INTO "Students" ("name", "start_year") VALUES
		('Никита',  2021),
		('Алексей', 2025),
		('Виктор',  2024),
		('Николай', 2021),
		('Павел',   2023)
	RETURNING "s_id"
),
students_ids AS (
	SELECT array_agg("s_id") AS ids FROM new_students
),
new_courses AS (
	-- Insert values into courses table --
	INSERT INTO "Courses" ("title", "hours") VALUES
		('Программная инженерия',      64),
		('Тестирование и отладка ПО', 128),
		('Базы данных',                80)
	RETURNING "c_id"
),
courses_ids AS (
	SELECT array_agg("c_id") AS ids FROM new_courses
)

-- Insert values into exams table --
INSERT INTO "Exams" ("c_id", "s_id", "score") VALUES
	((SELECT ids[1] FROM courses_ids), (SELECT ids[1] FROM students_ids), 80),
	((SELECT ids[2] FROM courses_ids), (SELECT ids[1] FROM students_ids), 80),
	((SELECT ids[3] FROM courses_ids), (SELECT ids[1] FROM students_ids), 80),

	((SELECT ids[1] FROM courses_ids), (SELECT ids[2] FROM students_ids), 60),
	((SELECT ids[2] FROM courses_ids), (SELECT ids[2] FROM students_ids), 50),

	((SELECT ids[3] FROM courses_ids), (SELECT ids[3] FROM students_ids), 90);
