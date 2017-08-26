.. _deployment:

Continuous deployment
======================

Continuous deployment is a way to deploy content (or software) automatically under certain conditions, such as "tests are passing".

In technical writing, continuous deployment is one of the aspects of a general workflow to make sure the documentation is always
in sync with the software.

Sphinx, like other static website generators are really easy to use for continuous deployment.

In this tutorial we assume that you have some prerequisite knowledge about:

- GitHub (how to use it on a basic level, what is a branch, what is a pull request)
- Sphinx (how to install it, how to build the output, what are extensions)

The result of the tutorial is the following setup:

#. A central Git repository contains the published documentation sources.
#. Every time a pull request is sent to Master:
   #. Build the documentation using the source files of the branch
   #. Run tests on the documentation:

      #. Check the links
      #. Check the spelling
      #. Check the English quality

   #. If every test passes, allow merging the pull request to Master.

#. On every merge to Master:
   #. Build the docs with the latest merged sources.
   #. Run the tests (same tests as on the pull request).
   #. If the tests are passing, publish the sources to Amazon S3.

This kind of setup saves a lot of time to any technical writer and it fairly simple to create.

The other advantage is that it allows contributions from any member of your company, as long as they have access to Git and a basic
understanding of it.

Let's get started.


Setting up the repository
-------------------------

Before you begin, make sue you are the admin of the documentation repo.

For the setup to be efficient at protecting the master branch, protect the master branch so that no one is allowed to push to it:

#. Connect to your GitHub account and open your repository.
#. Click :guilabel:`Settings` > :guilabel:`Branches`.
#. In :guilabel:`Protected Branches`, select :guilabel:`Master` and select the following options:

   - :guilabel:`Protect this branch`
   - :guilabel:`Require pull request reviews before merging`
   - :guilabel:`Require status checks to pass before merging`
   - :guilabel:`Require branches to be up to date before merging`

#. Click :guilabel:`Save changes`.

If you are the admin of your repo, you're now the only captain on board, which is good in this case, because nobody will be able
to mess up the published documentation (Master branch) without you knowing about this.


Setting up Travis CI
--------------------

Travis CI is a service that can be integrated with GitHub and that can run scripts whenever specific GitHub events happen,
such as a push, a pull request, etc.

To set it up:

#. Go to `travis-ci.org <https://travis-ci.org/>`_.
#. Click :guilabel:`Sign in with GitHub` then click :guilabel:`Authorize travis-ci`.
#. Refresh the page after a few seconds then click your profile name at the top right corner, then click :guilabel:`Accounts`.

   This page lists all the repositories of your GitHub account.

#. Click the toggle next to your documentation repository to tell Travis to monitor it.
#. Click the gear icon to open the settings.
#.

#. Click :guilabel:`Settings` > :guilabel:`Integration & services`.
#. Click :guilabel:`Add service` and type ``Travis CI``.
