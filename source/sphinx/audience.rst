Targeted publishing
===================

Targeted publishing consists in generating a specific version of the documentation for a specific audience from
a single set of source files, this is commonly referred to as **single sourcing**.

An obvious example is the difference between internal and public documentation. The internal version of the
documentation contains all the public documentation and additional internal-only pages.

Let's make Sphinx generate 2 versions of the documentation from one repository.


Tagging the internal content
----------------------------

Before we can have Sphinx build the internal or public version of the documentation, you must tag all the internal
content with the ``only`` `directive <http://www.sphinx-doc.org/en/stable/markup/misc.html#directive-only>`_.

This directive takes one parameter that is a tag/keyword of your choice. The content of the directive (the text
indented under it) is what is considered as "tagged". In our case, the ``internal`` tag sounds relatively sane
to describe the tagged content. Other typical examples could be versions (1.2, 1.3...), or user types (admin, dev, enduser...).


.. code-block:: rst

    Title
    -----

    Some public text here...

    .. only:: internal

       This text in only displayed in the internal documentation.

    Some more public text here.

If you try to build the output using ``make html``, the *internal* text would not appear, so let's
configure Sphinx to build the internal output in which the text must appear.


Building the internal version
-----------------------------

The `Sphinx command line`_ (``sphinx-build``) can take the ``-t`` argument that allows you to specify which tags
should be taken into consideration during the build.

#. Open the Makefile created by Sphinx in the root folder of the repository. It should look similar to the
   Makefile of the project used to build this website:

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

   This file contains *targets*, these are specific keywords that you attach to ``make`` such as ``make html`` to
   run a set of instructions.

   There are 2 targets in this file:

   #. ``help``: it displays the help.
   #. ``%``: this a special target that runs for any command that is not ``help``.

#. Add a new target called ``htmlinternal``:

   .. code-block:: make

      htmlinternal:
      	@echo "Building internal docs"
      	@mkdir -p buildinternal/html
      	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "buildinternal/html" $(SPHINXOPTS) $(O) -t internal

#. To build the internal documentation, run:

   .. code-block:: bash

      make htmlinternal

   The output file are in the ``buildinternal/html`` folder.

   .. note:: To build the publice documentation (or rather *non-internal* documentation, run:

             .. code-block:: bash

                make html

.. important:: This is a great feature but its behaviour is a bit buggy. Make sure to test your output
   when you use it.

.. _Sphinx command line: http://www.sphinx-doc.org/en/master/man/sphinx-build.html?highlight=command%20line#cmdoption-sphinx-build-t