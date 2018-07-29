
Configuring the repository
--------------------------

Before you begin, make sure you are the admin of the documentation repo.

Protect the master branch so that no one is allowed to push to it:

#. Connect to your GitHub account and open your repository.
#. Click :guilabel:`Settings` > :guilabel:`Branches`.
#. In :guilabel:`Protected Branches`, select :guilabel:`Master` and select the following options:

   - :guilabel:`Protect this branch`
   - :guilabel:`Require pull request reviews before merging`
   - :guilabel:`Require status checks to pass before merging`
   - :guilabel:`Require branches to be up to date before merging`

#. Click :guilabel:`Save changes`.

If you are the admin of your repo, you're now the only captain on board, which is good in this case because nobody
will be able to mess up the published documentation (Master branch) without you knowing about this.