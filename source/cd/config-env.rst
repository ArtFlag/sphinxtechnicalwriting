
Creating a development environment
----------------------------------

Your repository hosts the content that must be built with our static website generator.
The static website generator is not in the repository, only the documentation files and other configuration files are hosted.
The simple rule is **do not host files that can be generated**.

This means that anyone who wants to modify the documentation must setup Sphinx and the rest of the tool chain to build the
documentation. This required setup to build the docs is called a **development environment**.

As you can imagine, setting up a development environment is something that can be tedious. Because we want to promote
contributions, let's make this one-time setup as painless as possible.

#. Create a ``requirements.txt`` file at the root of your repository.
   This file should contain every name of the parts needed to build the documentation (Python modules, extensions, etc).

#. Go through your Sphinx ``conf.py`` file and add the name of each extension to the ``requirements.txt`` file.
   One extension name per line.

   .. admonition:: Example

      The ``requirements.txt`` file of the project used to build the docs you are reading now contains:

      .. code-block:: bash

         sphinx
         sphinxcontrib-mermaid

#. Push this file to your master branch of your repository.

This file is ready to be used by ``pip`` to install every Python module needed by your docs platform.

To use it, contributors who already have Python installed, enter:

.. code-block:: bash

   pip install -r requirements.txt

Why do we care about our contributors so early in the project? Because Travis CI could be seen as one. A special
contributor that only builds the documentation, and never contributes (sad).
