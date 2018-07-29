Displaying the full table of contents
-------------------------------------

By default, Sphinx displayed the :abbr:`TOC (table of contents)` based on the page that the user is reading.

The scope changes depending on the page which can be a nightmare for certain users. I'm one of these users.
I feel that it is extremely confusing and prevents me from understanding the logic of the TOC designed by the writer.

Fear not, it is possible to display one static TOC by using the ``fulltoc`` extension.
Refer to the `installation procedure <https://sphinxcontrib-fulltoc.readthedocs.io/en/latest/install.html#basic-installation>`__.

You can now split your TOC in as many sections as you need.

.. admonition:: Example

   The following code generates 2 separate sections with their own structure.

   .. code-block:: rst

      .. toctree::
      :caption: Integration guides

       myguide1.rst
       myguide2.rst

      .. toctree::
      :caption: API tutorials

       blablaapi.rst
       blibliapi.rst

