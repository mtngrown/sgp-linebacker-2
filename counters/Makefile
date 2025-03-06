# Makefile for converting SVG counter sheets to PDF using Inkscape

SVG_FILES := us-counter-sheet.svg \
             nv-counter-sheet.svg \
             b52-counter.svg \
						 plus-counter.svg \
						 f4-counter.svg \
             f111-counter.svg \
             mig21-counter.svg \
             radar-counter.svg \
             hit-counter.svg


PDF_FILES := $(SVG_FILES:.svg=.pdf)

# Default target
all: $(PDF_FILES)

# Rule to convert SVG to PDF using Inkscape
%.pdf: %.svg
	inkscape $< --export-type=pdf --export-filename=$@

# Clean up generated PDF files
clean:
	rm -f $(PDF_FILES)

.PHONY: all clean

