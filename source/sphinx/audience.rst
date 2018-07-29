Targeted publishing
===================

Targeted publishing consist in generating a specific version of the documentation for a specific audience from a single
set of source files.

An obvious example is the difference between internal and public documentation. These are 2 audiences that intersect
but the information for the internal audience must not be part of the public documentation. Let's make Sphinx
generate 2 versions of the documentation for one repository (single-sourcing).


Tagging the internal content
----------------------------

Before we can have Sphinx build the internal or public version of the documentation, you must tag each content section
that is internal.

You can use the ``only`` directive for this.
See the `Sphinx documentation <http://www.sphinx-doc.org/en/stable/markup/misc.html#directive-only>`__.
This directive takes one parameter that is a tag of your choice. In our case, ``internal`` sounds relatively sane.
The content of the directive (the text indented below it) it what is considered as "tagged".

.. code-block:: rst

    Title
    -----

    Some public text here...

    .. only:: internal

       This text in only displayed in the internal documentation.

    Some more public text here.

If you try to buid the output now, the text would not appear, so let's configure Sphinx to build the internal output in which the
text must appear.


Building the internal version
-----------------------------

The Sphinx command line (``sphinx-build``) can take the ``-t`` argument that allows you to specify which tags should be taken
into consideration during the build.

#. Open the Makefile created by Sphinx in the root folder of the repository. It should look similar to the Makefile of the project used to build this website:

   .. code-block:: guess

        # You can set these variables from the command line.
        SPHINXOPTS    = --color
        SPHINXBUILD   = python -msphinx
        SPHINXPROJ    = sphinxtechnicalwriting
        SOURCEDIR     = source
        BUILDDIR      = build

        # Put it first so that "make" without argument is like "make help".
        help:
        	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

        .PHONY: help Makefile

        # Catch-all target: route all unknown targets to Sphinx using the new
        # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
        %: Makefile
        	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

   This file contains ``targets`` or specific keywords that run a set of instructions. For example, ``help`` is a target
   that is run when you type ``make help``. The ``%`` target is a special target that is run for any command that is not ``help``.


#. Add a new target called ``htmlinternal``:

   .. code-block:: make

      htmlinternal:
    	@echo "Building internal docs"
    	@mkdir -p buildinternal
        @mkdir -p buildinternal/html
    	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "buildinternal/html" $(SPHINXOPTS) $(O) -t internal

#. Run ``make htmlinternal`` to build the internal documentation. The output file are in the ``buildinternal/html``
   folder. Running ``make html`` still builds the public documentation (or non-internal documentation, more
   exactly).

.. important:: This is a great feature but its behaviour is a bit buggy and you should make sure to test your output
   when you use it.


