import os
import time

t1 = time.time()
os.system('xelatex pgfmanual-zh.tex')
t2 = time.time()
os.system('xelatex -interaction=batchmode pgfmanual-zh.tex')
t3 = time.time()

dt1 = t2 - t1
dt2 = t3 - t2

print('Elapsed time dt1: {} s'.format(round(dt1,2)))
print('Elapsed time dt2: {} s'.format(round(dt2,2)))

