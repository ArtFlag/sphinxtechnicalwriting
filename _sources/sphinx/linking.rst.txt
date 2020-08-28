Using aliases to create links
-----------------------------

Aliases are labels that you can attach to titles (or anything else) to avoid referring to the titles themselves in case they
change. Instead you create a link to the alias and you get the freedom of changing the corresponding title as
much as needed without worrying about broken links.

This is essential as Sphinx is not a :abbr:`CMS (Content Management System)`. Changing a file name or lists of
titles can potentially be a lot of work compared to proprietary software that will rename all links for you
automatically.

For example, imagine the following title:

.. code-block:: rst

   Creating aliases
   ----------------

You can refer to it by using the standard rST link markup:

.. code-block:: rst

   link to `Creating aliases`_

This link will be broken as soon as you change the title.

Instead, refer to a label:

.. code-block:: rst

   .. _create-alias:

   Creating aliases
   ----------------

And link to it:

.. code-block:: rst

   unbreakable link to :ref:`create-alias`

.. note:: You can only create such a link using the ``ref`` role, which is recommended in the vast majority of cases.
