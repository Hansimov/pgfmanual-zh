@echo off
rem latexmk -pv -xelatex translation-schedule.tex
latexmk -pv -pdf translation-schedule.tex
rem echo Converting pdf to png ...
rem F:/Technology/ImageMagick/convert -density 200 translation-schedule.pdf -background "#FFFFFF" -flatten translation-schedule.png