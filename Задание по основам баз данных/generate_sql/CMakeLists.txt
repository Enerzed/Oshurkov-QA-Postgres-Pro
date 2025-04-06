cmake_minimum_required (VERSION 3.16)


project ("generate_sql")

add_executable (generate_sql "generate_sql.c" "generate_sql.h")

set_property(TARGET generate_sql PROPERTY C_STANDARD 23)