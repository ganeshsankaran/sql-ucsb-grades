import matplotlib.pyplot as plt
import numpy as np
import sqlite3
import sys

dept = sys.argv[1]
cnum = sys.argv[2]
qtr = sys.argv[3]
yr = sys.argv[4]

query = '''
select
    grade,
    freq
from Grades
where
    dept = '{}'
    and cnum = '{}'
    and qtr = '{}'
    and yr = {}
order by gpa desc, grade desc
'''

cxn = sqlite3.connect('grades.db')
cur = cxn.cursor()
cur.execute(query.format(dept, cnum, qtr, yr))
rs = cur.fetchall()

if len(rs) == 0:
    print('No results!')
    sys.exit(0)

grades = np.array([row[0] for row in rs])
freq = np.array([row[1] for row in rs])
    
plt.bar(grades, freq)
plt.xlabel('Grade')
plt.ylabel('Frequency (count)')
plt.title('Grade Distribution for {} {} ({} {})' \
        .format(dept, cnum, qtr, yr))
plt.show()