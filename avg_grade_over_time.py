import matplotlib.pyplot as plt
import numpy as np
import sqlite3
import sys

dept = sys.argv[1]
cnum = sys.argv[2]

query = '''
select 
    qtr, 
    yr,
    sum(gpa * freq) / sum(freq) as avggpa
from Grades
where 
    dept = '{}'
    and cnum = '{}'
    and grade not in ('F', 'P', 'NP', 'S', 'U')
group by 
    qtr, 
    yr
order by 
    yr, 
    case qtr 
        when 'Winter' then 0
        when 'Spring' then 1
        when 'Summer' then 2
        when 'Fall' then 3
    end
'''

cxn = sqlite3.connect('grades.db')
cur = cxn.cursor()
cur.execute(query.format(dept, cnum))
rs = cur.fetchall()

if len(rs) == 0:
    print('No results!')
    sys.exit(0)

qtr = np.array(['{}{}'.format(row[0][0], row[1] % 100) for row in rs])
avggpa = np.array([row[2] for row in rs])

print(qtr)
    
plt.plot(qtr, avggpa)
plt.xlabel('Quarter')
plt.ylabel('Average GPA')
plt.title('Average GPA per Quarter for {} {}'.format(dept, cnum))
plt.show()

