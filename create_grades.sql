.open grades.db

create table Grades (
    qtr varchar(100),
    yr int,
    dept varchar(100),
    lvl varchar(100),
    cnum varchar(100),
    instr varchar(100),
    grade varchar(100),
    gpa real,
    freq int
);

.mode csv
.import grades_proc.csv Grades