.. _config-travis:

Publishing the docs with Travis
===============================

Travis looks for a file called ``.travis.yml`` at the root of your repo in order to know
what to do.

.. admonition:: Objective recap

   We need to tell Travis to:

   #. Install the an OS image and Python, as well as other languages you need, for example ``node.js``.
   #. Install all the pieces required to build the docs such as Sphinx and the extensions.
   #. Build the docs.
   #. (Optional) Run some tests.
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
        notifications:
          email:
            recipients:
              - one@example.com # your email here
            on_success: never
            on_failure: always

   .. admonition:: Explanations

      This file tells to Travis to apply the following steps:

      #. Set up a system that runs Python 3.6.
      #. Install node.js 6. We're not using this now but you might use node.js packages for your tests.
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

From now on, every time you push to the **master** branch, Travis builds the latest version of the docs and
publishes the output on github pages just like this current website published on
`https://artflag.github.io/sphinxtechnicalwriting/ <https://artflag.github.io/sphinxtechnicalwriting/>`__.

You can bend this setup as needed, for example you can call your own publishing script. That script could
publish your output files on Amazon S3, or copy the output files to your Apache server... Whatever works for you!

If you managed to do all this by yourself, you should be able to befriend a developer to complete the project.
