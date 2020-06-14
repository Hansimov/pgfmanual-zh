@echo off
rem gswin64c -sDEVICE=pngalpha -r216 -o ab.png ab.pdf
gswin64c -sDEVICE=png16m -r2880 -dDownScaleFactor=2 -o ab.png ab.pdf