# Compile the rules and the player aid.
# Create make directives for tex and pdf files.

# PDF_FILES = $(wildcard *.pdf)
PDF_FILES = player_aid.pdf \
            rules.pdf \
						nv-air-status.pdf \
						mission-display.pdf \
						us-air-status.pdf
TEX_FILES = $(wildcard *.tex)

all: $(PDF_FILES)


%.pdf: %.tex
	pdflatex $<

clean:
	rm -f $(PDF_FILES) *.aux *.log *.out
