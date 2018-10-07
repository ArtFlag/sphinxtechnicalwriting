Tasks
=====

VS Code allows you to create all sorts of tasks. A task is basically a command line, or a set of command lines
that you can call from the VS Code interface directly. For example, in software development, a task
could consist of calling a set of instructions to build the software and automatically run it in order to test it.


Build the documentation
-----------------------

What is the one action that any tech writer needs to do when writing docs without a visual tool (:abbr:`WYSIWYG
(What You See Is What You Get)`)? **Build the docs**. I personally build every few paragraphs, not necessarily to
check the output, but just to make sure that I did not make mistakes while writing rST.

Let's create a task that triggers a build from a keyboard shortcut:

#. Open a new task file:

   #. Press ``Cmd-Shift-P``.
   #. Type ``task``.
   #. Select :guilabel:`Tasks: Configure default build task` and select the default option.
      A new file opens containing the default skeleton of a task.

#. Replace the whole content by the following code:

   .. code-block:: json

      {
       "version": "2.0.0",
       "tasks": [
          {
            "label": "build",
            "type": "shell",
            "command": "make html",
            "group": {
                "kind": "build",
                "isDefault": true
            }
          }
        ]
      }

   Notice the ``command`` field, it contains ``make html``, the Sphinx command to build the HTML output.
   That's all we need to create our most useful task.

#. Save.
#. To run it, press ``Cmd-Shift-B`` and VS Code builds the docs. Cool beans.

   .. note:: If you get another VS Code question about scanning the task output,
      select :guilabel:`Never scan the task output`.

That's cool, no more window shifting when you want to build but you still have to open your browser and open the
output of the file that you were editing.


Open the output of the current file
-----------------------------------

The idea of this task is to look at which file is displayed in VS Code, which should be the file you have
working on, and open it in your browser.

#. Open the task file:

   #. Press ``Cmd-Shift-P``.

   #. Type ``task``.

   #. Select :guilabel:`Tasks: Configure default build task` and select the default option.
      The task file you edited earlier opens.

#. Replace the current content by the following code:

   .. code-block:: json

      {
        "version": "2.0.0",
        "tasks": [
          {
            "label": "build",
            "command": "make html",
            "type": "shell",
            "presentation": {
              "reveal": "always"
            },
            "group": {
              "kind": "build",
              "isDefault": true
            }
          },
          {
            "label": "open page",
            "command": "open `find build/html -name ${fileBasenameNoExtension}.html`",
            "type": "shell",
            "presentation": {
              "reveal": "always"
            },
            "group": {
              "kind": "build",
              "isDefault": true
            }
          }
        ]
      }

   This file now contains 2 tasks. The first one is the build command that we created before. The new one
   labeled ``open page`` runs an ``open`` command on the Sphinx build directory, looking for the file that's
   currently opened in VS code.

   .. note:: The command will probably get confused if you want to open a file that does not have a unique name
      in your repository but aside this case, it's a great time saver.

#. Save.
#. To run it, press ``Cmd-Shift-B`` and select :guilabel:`open page`. The page opens in your default browser.

If you find yourself repeating the same actions, think about adding more tasks.
