
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