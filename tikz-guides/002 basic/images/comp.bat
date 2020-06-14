@echo off
rem xelatex -aux-directory=latex-temp -interaction=batchmode von-neumann.tex
rem xelatex -aux-directory=latex-temp von-neumann.tex

pdflatex -shell-escape -interaction=batchmode -aux-directory=latex-temp "&von-neumann" von-neumann.tex
rem sumatrapdf von-neumann.pdf

rem gswin64c -sDEVICE=pngalpha -r216 -o von-neumann.png von-neumann.pdf
rem gswin64c -sDEVICE=png16m -r1440 -dDownScaleFactor=8 -o von-neumann.png von-neumann.pdf