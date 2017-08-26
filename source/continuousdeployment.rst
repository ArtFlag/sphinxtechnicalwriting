.. _deployment:

Continuous deployment
======================

Continuous deployment is a way to deploy content (or software) automatically under certain conditions, such as "tests are passing".

In technical writing, continuous deployment is one of the aspects of a general workflow to make sure the documentation is always
in sync with the software.

Sphinx, like other static website generators, is really easy to use for continuous deployment.

Prerequisites
-------------

In this tutorial we assume that you have some prerequisite knowledge about:

- GitHub (how to use it on a basic level, what is a branch, what is a pull request)
- Sphinx (how to install it, how to build the output, what are extensions)


Final setup
-----------

The result of the tutorial is the following setup:

#. A central Git repository contains the published documentation sources.
#. Every time a pull request is sent to Master:

   #. Build the documentation using the source files of the branch.

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
#. Select:

   - Build only if .travis.yml is present
   - Build branch updates
   - Build pull request updates

#. Got to GitHub and click :guilabel:`Settings` > :guilabel:`Integration & services`.

You should see Travis CI in the list of services already added.

We configured Travis CI to look for a file named ``.travis.yml``. Let's create it.


Creating the ``.travis.yml`` file
---------------------------------

This file tells Travis CI what to do.

In our case, we need to tell it to build the docs and upload the output to Amazon S3:

.. code-block:: yaml

   language: python
   branches:
     only:
     - master
   python:
     - '2.7'
   sudo: false
   install:
     - pip install -r requirements.txt
   script:
     - make html linkcheck
   after_success:
   - python ./upload-docs.py

This file has to follow Travis CI specifications, but it's already quite clear:

#. Use Python 2.7 as main language, and run only on the Master branch.
#. Install the python modules contained the ``requirements.txt`` file of the repo.

   This file contains names of the Python modules we need (dependencies):

   .. code-block:: yaml

      #Sphinx
      sphinx

      #Sphinx extensions
      sphinxcontrib-fulltoc

      #Module to upload files to Amazon S3
      boto3

#. Once the environment is ready, run the following command: ``make html linkcheck``.

   The commands builds the HTML output from Sphinx and runs the link checker.

#. If the previous script succeeded, run the following command: ``python ./upload-docs.py``.

   This Python file contains a script to upload the output to Amazon S3. More on this later.

That's it for a first version! Every time Master gets a new commit, Travis builds the docs and if
the build is successful, it publishes the output on S3.

Before we make it test our documentation more extensively, let's talk about testing.



