#include "generate_sql.h"



void generate_name(int len, char buf[])
{
	for (int i = 0; i < len; i++)
	{
		buf[i] = rand() % 26 + 'a';
	}
	buf[len] = '\0';
}


int main()
{
	FILE* f;
	f = fopen("generate_sql.sql", "w");

	fprintf(f, "WITH new_students AS\n(\n");
	fprintf(f, "\tINSERT INTO \"Students\" (\"name\", \"start_year\") VALUES\n");
	
	for (int i = 0; i < MAX_STUDENTS; i++)
	{
		char name[11];
		generate_name(10, name);
		fprintf(f, "\t\t('%s', %d)", name, rand() % 10000);
		if (i < MAX_STUDENTS - 1)
			fprintf(f, ",\n");
		else
			fprintf(f, "\n");
	}

	fprintf(f, "\tRETURNING \"s_id\"\n),\n");

	fprintf(f, "students_ids AS\n(\n\tSELECT array_agg(\"s_id\") AS ids FROM new_students\n),\n");

	fprintf(f, "new_courses AS\n(\n\tINSERT INTO \"Courses\" (\"title\", \"hours\") VALUES\n");

	for (int i = 0; i < MAX_COURSES; i++)
	{
		char name[11];
		generate_name(10, name);
		fprintf(f, "\t\t('%s', %d)", name, rand() % 100);
		if (i < MAX_COURSES - 1)
			fprintf(f, ",\n");
		else
			fprintf(f, "\n");
	}

	fprintf(f, "\tRETURNING \"c_id\"\n),\n");

	fprintf(f, "courses_ids AS\n(\n\tSELECT array_agg(\"c_id\") AS ids FROM new_courses\n)\n");

	fprintf(f, "INSERT INTO \"Exams\" (\"c_id\", \"s_id\", \"score\") VALUES\n");

	bool is_first = true;
	for (int i = 0; i < MAX_STUDENTS; i++)
	{
		for (int j = 0; j < MAX_COURSES; j++)
		{
			if (rand() % 100 < CHANCE)
			{
				if (is_first)
				{
					is_first = false;
				}
				else
				{
					fprintf(f, ",\n");
				}
				fprintf(f, "((SELECT ids[%d] FROM courses_ids), (SELECT ids[%d] FROM students_ids), %d)", j + 1, i + 1, rand() % 100);
			}
		}
	}
	fprintf(f, ";");

	fclose(f);
	return 0;
}
