.. _deployment:

Continuous deployment
======================

Continuous deployment is a way to deploy content (or software) automatically under certain conditions,
such as *tests are passing*.

In technical writing, continuous deployment can be used to help tech writers keep up with the product(s) to be
documented by automating as many things as possible such as tests and deployment.

Sphinx, like other static website generators, is really easy to use and can be used along GitHub and Travis.


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
   #. If the tests are passing, publish the output to GitHub Pages.

This kind of setup saves a lot of time to any technical writer and it's fairly simple to create.

The other advantage is that it allows contributions from any member of your company, as long as they have access to GitHub and a basic
understanding of it.

Let's get started.


Configuring the repository
--------------------------

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

If you are the admin of your repo, you're now the only captain on board, which is good in this case because nobody will be able
to mess up the published documentation (Master branch) without you knowing about this.


Creating a development environment
----------------------------------

Your repository hosts the content and depends on the software installed on the contributor to build the output (for example Sphinx).

These tools are not hosted but installed locally on the contributor's computer. If
a contributor doesn't have Python installed, building the docs is a no-go. Same thing if the
contributor doesn't have Sphinx, or a specific extension... This required setup to build the docs
is called a **development environment**.

Contributors must replicate this development environment to work on the docs. To make the creation of this
development environment smooth, you must remove yourself from the equation so that you don't have to run around your
workplace installing Sphinx on every single contributor's computer.

Automating the configuration of the development environment is done with a ``requirements.txt`` file.
This file contains the list of all the Python modules required to build the docs.

#. Create a ``requirements.txt`` file at the root of your repository.
#. Go through your Sphinx ``conf.py`` file and add the name of each extension to the requirements.txt file.
   One extension name per line.

   .. admonition:: Example

      The ``requirements.txt`` file of the project used to build the docs you are reading now contains:

      .. code-block:: bash

         sphinx
         sphinxcontrib-mermaid

#. Push this file to your master branch.

This file is ready to be used by ``pip`` to install every Python module needed by your docs platform.

To use it, contributors who already have Python installed, would type: ``pip install -r requirements.txt``.

Why do we care about our contributors so early in the project? Because Travis CI could be seen as one, or at least
as an actor of our docs platform.


Linking GitHub and Travis
-------------------------

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

   - :guilabel:`Build only if .travis.yml is present`
   - :guilabel:`Build branch updates`
   - :guilabel:`Build pull request updates`

#. Go to GitHub and click :guilabel:`Settings` > :guilabel:`Applications` > :guilabel:`Authorized OAuth Apps`.

   You should see Travis CI in the list of services already added.

Travis has access to the repositories you ticked. You can now tell Travis what to do with your repo.


Setting up Travis to test and publish the documentation
-------------------------------------------------------

Travis looks for a file called ``.travis.yml`` at the root of your repo in order to know
what to do with it.

.. admonition:: Objective recap

   We need to tell Travis to:

   #. Install the an OS image and Python, as well as other languages you need, for example ``node.js``.
   #. Install all the pieces required to build the docs such as Sphinx and the extensions. Spoiler alert: that's why we needed
      the ``requirements.txt`` early on.
   #. Build the docs.
   #. Run some tests.
   #. Publish the docs on GitHub pages.

To automate the publishing of the documentation:

#. Create ``.travis.yml`` at the root of your repository.
#. Dump the following content into the file:

   .. code-block:: yaml

      language: python
      branches:
        only:
        - master
      python:
      - '3.6'
      node_js: 6
      install:
      - pip install -U pip
      - pip install -r requirements.txt
      script:
      - make html
      after_success:
        #test the docs
      deploy:
        provider: pages
        skip_cleanup: true
        github_token: $token #set in the Travis dashboard
        local_dir: build/html
        on:
          branch: master

   .. admonition:: Explanations

      This file tells to Travis to apply the following steps:

      #. Set up a system that runs Python 3.6.
      #. Install nvm to be able to run node.js packages. We're not using this now but you might use node.js packages for your tests, so Travis is ready to go.
      #. Install pip and install all the Python modules contained in ``requirements.txt`` (Sphinx & friends).
      #. Run ``make html`` to build the docs.
      #. If the build succeeds, publish the docs to GitHub Pages. If the build fails, you are notified by email and you can start fixing the problems.

   The file refers to a ``$token`` variable that has be defined.

#. Log in to your GitHub account and go into :guilabel:`Settings` > :guilabel:`Developer settings` > :guilabel:`Personal access tokens`

#. Click :guilabel:`Generate new token`, add a description, such as ``Travis token`` and tick the :guilabel:`repo`
   checkbox then click :guilabel:`Generate token`.

#. Copy the token.

#. From the Travis settings page of your repository, add a new encrypted environment variable called ``token``.

#. Commit and push your file to your **master** branch.
