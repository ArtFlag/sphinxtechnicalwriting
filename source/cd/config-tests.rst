.. _config-tests:

Setting up tests
================

Now that Travis can tap into the repository, we can prepare task for it to perform. An essential part
is testing. The first obvious test is *Can the docs be built?*. Other tests are usually:

- Is the spelling ok?
- Are the docs matching my style guide?

We can tests these using `Vale`_. It is a command line tool that checks user-defined patterns. Let's set it up.


Defining styles
---------------

To understand how to define styles, see the `official docs <styles_>`_.

Let's define 3 styles:
- Forbid ``please`` or ``thank you``.
- Forbid double spaces.
- Forbid the use of uncertain tenses (``should``, ``ought``...).

#. At the root of your project, create a folder ``styles``.
#. Create a file named ``Polite.yml`` that contains:

   .. literalinclude:: ../../styles/mystyles/Polite.yml

#. Create a file named ``Spacing.yml`` that contains:

   .. literalinclude:: ../../styles/mystyles/Spacing.yml

#. Create a file named ``Tenses.yml`` that contains:

   .. literalinclude:: ../../styles/mystyles/Tenses.yml

#. Add these 3 files to the ``styles`` folder.

#. At the root of you project, create a file named ``.vale.ini`` that contains:

   .. literalinclude:: ../../.vale.ini

There are compilations of styles available, see `Vale styles`_.


Running Vale
------------

We've defined some styles, let's check if our documentation contains issues:

#. `Install Vale`_.
#. Open the terminal to your project folder and run:

   .. code-block:: console

      vale source

Vale reports the errors in your project, if any.

.. note:: Vale errors do not prevent Sphinx from building.


**Next step:** :ref:`config-travis`.

.. _Vale: https://github.com/errata-ai/vale/
.. _Install Vale: https://errata-ai.gitbook.io/vale/getting-started/installation
.. _styles: https://errata-ai.gitbook.io/vale/getting-started/styles
.. _Vale styles: https://github.com/errata-ai/vale/tree/master/styles
