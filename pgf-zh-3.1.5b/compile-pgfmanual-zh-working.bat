@echo off
rem pdflatex pgfmanual-zh.tex
latexmk -pool-size=10000000 -pv -xelatex pgfmanual-zh-working.tex