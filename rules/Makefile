# Compile the rules and the player aid.
# Create make directives for tex and pdf files.

# PDF_FILES = $(wildcard *.pdf)
PDF_FILES = player_aid.pdf \
            rules.pdf \
						nv-air-status.pdf \
						mission-display.pdf \
						us-air-status.pdf \
						hh-bombing-missions.pdf \
            victory-points.pdf \
            sam-supply.pdf \
            game-turn.pdf
PDF_FILES += $(wildcard *.tikz)

TEX_FILES = $(wildcard *.tex)
# Add all the *.tikz files to the dependencies
TIKZ_FILES = $(wildcard *.tikz)

# Ensure page-9.tex is treated as a dependency but not compiled separately
rules.pdf: rules.tex page-9.tex page-10.tex page-11.tex page-12.tex

all: $(PDF_FILES)

# Rule to build PDF from TEX, including potential TIKZ dependency
%.pdf: %.tex %.tikz
	xelatex $<

# Rule to handle TEX files without TIKZ dependencies
%.pdf: %.tex
	xelatex $<

clean:
	rm -f $(PDF_FILES) *.aux *.log *.out
