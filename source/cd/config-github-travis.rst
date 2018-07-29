
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
