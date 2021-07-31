.headers on
.mode column

-- find profs with highest avg. GPA for a course
.once avg_gpa_per_prof_for_course.txt
select 
    instr,
    count(distinct yr) as nyears,
    sum(gpa * freq) / sum(freq) as avggpa
from Grades
where 
    dept = 'CMPSC'
    and cnum = '130A'
    and grade not in ('P', 'NP', 'S', 'U')
group by instr
order by avggpa desc;

-- find courses with highest avg. GPA for a prof
.once avg_gpa_per_course_for_prof.txt
select 
    cnum,
    count(distinct yr) as nyears,
    sum(gpa * freq) / sum(freq) as avggpa
from Grades
where 
    dept = 'CMPSC'
    and instr = 'BULTAN T'
    and grade not in ('P', 'NP', 'S', 'U')
group by cnum
order by avggpa desc;

-- rank top 10 hardest courses
.once top_10_hardest_courses.txt
select 
    dept,
    cnum,
    count(distinct yr) as nyears,
    sum(gpa * freq) / sum(freq) as avggpa
from Grades
where 
    dept = 'CMPSC' 
    and grade not in ('P', 'NP', 'S', 'U')
group by 
    dept,
    cnum
having avggpa > 0.0
order by avggpa
limit 10;

-- rank top 10 hardest profs
.once top_10_hardest_profs.txt
select 
    instr,
    dept,
    count(distinct yr) as nyears,
    sum(gpa * freq) / sum(freq) as avggpa
from Grades
where grade not in ('P', 'NP', 'S', 'U')
group by 
    instr, 
    dept
having avggpa > 0.0
order by avggpa
limit 10;

-- rank top 10 hardest depts
.once top_10_hardest_depts.txt
select 
    dept,
    sum(gpa * freq) / sum(freq) as avggpa
from Grades
where grade not in ('P', 'NP', 'S', 'U')
group by 
    dept
having avggpa > 0.0
order by avggpa
limit 10;

-- rank easiest quarters
.once easiest_qtrs.txt
select 
    qtr,
    yr,
    sum(gpa * freq) / sum(freq) as avggpa
from Grades
where grade not in ('P', 'NP', 'S', 'U')
group by 
    qtr, 
    yr
having avggpa > 0.0
order by avggpa desc;