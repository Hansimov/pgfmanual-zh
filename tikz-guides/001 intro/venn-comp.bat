@echo off
xelatex -aux-directory=latex-temp venn.tex
echo "Converting pdf to png ..."
gswin64c -sDEVICE=pngalpha -r216 -o ./images/venn.png venn.pdf
sumatrapdf venn.pdf
cd ./images & venn.png