TEXCC := pdflatex
BAD_EXTS := *.aux *.log *.nav *.out *.snm *.toc

all : pres.pdf

clean :
	@rm -f $(BAD_EXTS) *.pdf

%.pdf : %.tex
	$(TEXCC) $<
	$(TEXCC) $<
	@rm -f $(BAD_EXTS)

.PHONY : all clean
