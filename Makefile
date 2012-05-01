CC=gcc
EMACS=/Applications/Emacs-23-4.app/Contents/MacOS/Emacs
BATCH_EMACS=$(EMACS) --batch -Q -l init-old.el sigproc-sp-org-new.org

all: sigproc-sp-org-new.pdf

sigproc-sp-org-new.tex: sigproc-sp-org-new.org
	$(BATCH_EMACS) -f org-export-as-latex

sigproc-sp-org-new.pdf: sigproc-sp-org-new.tex
	rm -f sigproc-sp-org-new.aux 
	if pdflatex sigproc-sp-org-new.tex </dev/null; then \
		true; \
	else \
		stat=$$?; touch sigproc-sp-org-new.pdf; exit $$stat; \
	fi
	bibtex sigproc-sp-org-new
	while grep "Rerun to get" sigproc-sp-org-new.log; do \
		if pdflatex sigproc-sp-org-new.tex </dev/null; then \
			true; \
		else \
			stat=$$?; touch sigproc-sp-org-new.pdf; exit $$stat; \
		fi; \
	done

sigproc-sp-org-new.ps: sigproc-sp-org-new.pdf
	pdf2ps sigproc-sp-org-new.pdf

clean:
	rm -f *.aux *.log tempo.ps *.dvi *.blg *.bbl *.toc *.tex *~ *.out sigproc-sp-org-new.pdf *.xml *.lot *.lof


