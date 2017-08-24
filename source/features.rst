Sphinx features for technical writing
=====================================

Sphinx offers some great features for technical writing. Some of them are offered out-of-the-box, some of them require
the installation of extensions.


Displaying the full table of contents
-------------------------------------

By default, Sphinx diplayed the :abbr:(TOC,`table of contents`) based on the page that the user is reading.
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



Using aliases to create links
-----------------------------

Aliases are labels that you can attach to titles to avoid referring to the titles themselves
in case they change. Instead you create a link to the alias and you get the freedom of changing the correponding title
as much as needed without worrying about broken links.

This is essential as Sphinx is not a CMS. Changing a file name of lists of titles can potentially be a lot of work compared to proprietary software
that will rename all links for you automatically.

For example, imagine the following title:

``
Creating aliases
----------------

``

