# Makefile for converting SVG counter sheets to PDF using Inkscape,
# then embedding the PDF in a LaTeX document using pdflatex.
# The tex file is map_sheet.tex.

SVG_FILES := map.svg \
             us-pilot-morale.svg
PDF_FILES := $(SVG_FILES:.svg=.pdf) # map_sheet.pdf
TEX_FILES := map_sheet.tex
BUILD_DIR := ../build

# Default target
all: $(PDF_FILES) # $(TEX_FILES)

# Rule to convert SVG to PDF using Inkscape
%.pdf: %.svg
	inkscape $< --export-type=pdf --export-filename=$@
	cp $@ $(BUILD_DIR)/

# Rule to convert LaTeX to PDF using pdflatex
%.pdf: %.tex
	pdflatex $<

# Clean up generated PDF files
clean:
	rm -f $(PDF_FILES) *.aux *.log *.out

.PHONY: all clean

