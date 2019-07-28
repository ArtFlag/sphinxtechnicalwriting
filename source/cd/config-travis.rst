.. _config-travis:

Publishing the docs with Travis
===============================

We need to tell Travis to:

#. Install everything required by our project.
#. Build the docs.
#. Run some tests via Vale. See the :ref:`previous step <config-tests>`.
#. Publish the docs on GitHub pages.


Generating a Travis token
-------------------------

You need to create a Travis token to allow it to use your GitHub account account.

#. Log in to your GitHub account and go into :guilabel:`Settings` > :guilabel:`Developer settings`
   > :guilabel:`Personal access tokens`

#. Click :guilabel:`Generate new token`, add a description, such as ``Travis token`` and tick the
   :guilabel:`repo` checkbox then click :guilabel:`Generate token`.

#. Copy the token.

#. From the Travis settings page of your repository, add a new encrypted environment variable called ``token``:

   .. figure:: images/travis-env.png


Creating the Travis config file
-------------------------------

To automate the publishing of the documentation, Travis looks for a ``.travis.yml`` file to know what to do.
Let's define it:

#. Create ``.travis.yml`` at the root of your repository.
#. Dump the following content into the file:

   .. literalinclude:: ../../.travis.yml

   This file tells to Travis to apply the following steps:

   #. Set up a system that runs Python 3.7.
   #. Install pip and install all the Python modules contained in the ``requirements.txt`` or ``Pipfile`` file.
   #. Define 2 `stages`_: *suild and test* and *deploy*.
      Stages are run sequentially but run the jobs they contain in parallel. A failed stage cancels the
      following stages.

      *build and test* does the following:

      #. Run ``make html`` to build the docs.
      #. Run Vale to check for style issues.

      *Deploy* deploys the docs to GitHub pages if the building and tests are successful.

#. Commit and push your file to your **master** branch.

From now on, every time you push to the **master** branch, Travis builds the latest version of the docs and
publishes the output on github pages just like this current website published on
`GitHub Pages <https://artflag.github.io/sphinxtechnicalwriting/>`__.

You can bend this setup as needed, for example you can call your own publishing script. You can use that script to
publish your output files on Amazon S3, or copy the output files to your Apache server... Whatever works for you!

If you managed to do all this by yourself, you should be able to befriend a developer to complete the project.


.. _stages: https://docs.travis-ci.com/user/build-stages/
