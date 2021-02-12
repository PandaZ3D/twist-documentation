.PHONY: typeset

typeset:
	pandoc                          \
	  --from         markdown       \
	  --to           latex          \
	  --template     template.tex   \
	  --out          twist_documentation.pdf \
	  --pdf-engine   xelatex        \
	  --listings \
	  vars.yaml `cat sections.txt`