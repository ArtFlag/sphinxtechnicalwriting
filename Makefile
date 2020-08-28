# You can set these variables from the command line.
SPHINXOPTS    = --color
SPHINXBUILD   = python -msphinx
SPHINXPROJ    = sphinxtechnicalwriting
SOURCEDIR     = source
BUILDDIR      = build
IMAGE_NAME    = sphinx_image

IN_DOCKER=docker run --rm -v $$(pwd):/sphinxtechnicalwriting $(IMAGE_NAME)
# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

image:
	@docker build -t sphinx_image .
html-docker:
	@${IN_DOCKER} make html