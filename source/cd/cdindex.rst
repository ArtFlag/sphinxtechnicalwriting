.. _deployment:

Continuous deployment
======================

.. contents:: :local:


Continuous deployment is a way to deploy (publish) software automatically and in short cycles.
Typically, the process is build the software, test the software, deploy. If any of these steps fails, the process is
interrupted.

Sphinx, like other static website generators, is really easy to use and can be used along GitHub and Travis.


Prerequisites
-------------

In this tutorial we assume that you have some prerequisite knowledge about:

- GitHub (how to use it on a basic level, what is a branch, what is a pull request...)
- Sphinx (how to install it, how to build the output, what are extensions...)


Final setup
-----------

The result of the tutorial is the following setup:

#. A central Git repository that contains the documentation sources.
#. Every time a pull request is sent to the master repository:

   #. Build the documentation using the source files of the branch.

   #. Run tests on the documentation:

      #. Check the links
      #. Check the spelling
      #. Check the English quality

   #. If all the tests pass, merge the pull request into Master.

#. On every merge into Master:

   #. Build the docs.
   #. Run the tests (same tests as on the pull request).
   #. If the tests are passing, publish the output to GitHub Pages.

This kind of setup saves a lot of time to any technical writer and is fairly simple to create.

The other advantage is that it allows contributions from any member of your company, as long as they have access to
GitHub and a basic understanding of it.

Let's get started.

Tutorial
--------

.. toctree::
   :maxdepth: 3
   :numbered:

   config-repo.rst
   config-env.rst
   config-github-travis.rst
   config-tests.rst
   config-travis.rst
