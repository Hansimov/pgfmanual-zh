@echo off
rem gswin64c -sDEVICE=pngalpha -r216 -o von-neumann.png von-neumann.pdf
gswin64c -sDEVICE=png16m -r2880 -dDownScaleFactor=8 -o von-neumann.png von-neumann.pdf