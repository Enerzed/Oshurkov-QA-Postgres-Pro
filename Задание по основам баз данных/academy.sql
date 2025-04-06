-- Create tables section -------------------------------------------------

-- Table Students

CREATE TABLE "Students"
(
  "s_id" Serial NOT NULL,
  "name" Character varying(128) NOT NULL,
  "start_year" Integer
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Students" ADD CONSTRAINT "PK_Students" PRIMARY KEY ("s_id")
;

-- Table Courses

CREATE TABLE "Courses"
(
  "c_id" Serial NOT NULL,
  "title" Character varying(128) NOT NULL,
  "hours" Integer DEFAULT 0 NOT NULL
    CONSTRAINT "ge0" CHECK (hours >= 0)
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Courses" ADD CONSTRAINT "PK_Courses" PRIMARY KEY ("c_id")
;

-- Table Exams

CREATE TABLE "Exams"
(
  "score" Integer DEFAULT 0 NOT NULL
    CONSTRAINT "ge0" CHECK (score >= 0),
  "s_id" Integer NOT NULL,
  "c_id" Integer NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Exams" ADD CONSTRAINT "PK_Exams" PRIMARY KEY ("s_id","c_id")
;

-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE "Exams"
  ADD CONSTRAINT "StudentsExams"
    FOREIGN KEY ("s_id")
    REFERENCES "Students" ("s_id")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Exams"
  ADD CONSTRAINT "CoursesExams"
    FOREIGN KEY ("c_id")
    REFERENCES "Courses" ("c_id")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

