# Makefile for converting SVG counter sheets to PDF using Inkscape

SVG_FILES := map.svg
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

