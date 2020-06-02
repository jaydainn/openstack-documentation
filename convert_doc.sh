#!/bin/sh

partie_pdf() {
		sed 's/─/-/g' *.md > tmp.md
		pandoc tmp.md -o $(echo $1).pdf
		rm tmp.md
}



#	cover
###################
cat << EOF > cover.tex
\documentclass[12pt, letter ]{article}
\usepackage[utf8]{inputenc}

\title{OpenStack : la pertinence de l'utilisation future d'OpenStack en IaaS pour l'université de Limoges}
\author{Philippe Krejčí}
\date{Juin 2020}

\begin{document}

\begin{titlepage}
\maketitle
\end{titlepage}
\end{document}
EOF
texi2pdf cover.tex
ls | grep cover | sed 's/cover.pdf//'

#	0_Intro
###################
cd doc/0_Intro
partie_pdf 0_Intro
cd ../..

#  1_OpenStack
###################
cd doc/1_OpenStack
partie_pdf 1_OpenStack
cd ../..



#	unification
####################
pdfunite cover.pdf doc/0_Intro/0_Intro.pdf doc/1_OpenStack/1_OpenStack.pdf  final.pdf
rm cover.pdf doc/0_Intro/0_Intro.pdf doc/1_OpenStack/1_OpenStack.pdf
