all:
	cd ../src && echo "create_plots" | octave && mv *.png ../docs/ && cd ../docs
	pdflatex report.tex && pdflatex report.tex
clean:
	rm *.{pdf,aux,log,png}
