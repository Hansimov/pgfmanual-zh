@echo off
rem latexmk -pv -xelatex translation-schedule.tex
rem latexmk -pv -pdf translation-schedule.tex
echo Converting pdf to png ...
D:/ImageMagick/convert -density 200 ./translation-schedule.pdf -background "#FFFFFF" -flatten ./translation-schedule.png
rem pause