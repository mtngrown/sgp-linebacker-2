

PDF_FILES := map_sheet.pdf \
             player-aid.pdf
TEX_FILES := map_sheet.tex \
             player-aid.tex

# Default target
all: $(PDF_FILES) $(TEX_FILES)

# Rule to convert SVG to PDF using Inkscape
# %.pdf: %.svg
# 	inkscape $< --export-type=pdf --export-filename=$@
# 	cp $@ $(BUILD_DIR)/

# Rule to convert LaTeX to PDF using pdflatex
%.pdf: %.tex
	pdflatex $<

# Clean up generated PDF files
clean:
	rm -f $(PDF_FILES) *.aux *.log *.out

.PHONY: all clean

