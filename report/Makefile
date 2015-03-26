CC = pdflatex
VIEW = evince

SRC = lab_report.tex
TARGET = lab_report.pdf

all: ${TARGET}
	${VIEW} ${TARGET} &

${TARGET}: ${SRC}
	${CC} $^

clean:
	rm -f *.pdf *.aux *.log *.bbl *.toc *.out *~

rebuild: clean all

.PHONY: all rebuild clean
