Creating tasks
==============

VS Code allows you to create all sorts of tasks. A task is basically a command line, or a set of command lines that
you can call from the VS Code directly, from the interface. For example, in software development, a task could
consist of calling a set of instructions to build the software and run it to test.

What is the one action that any tech writer needs to do when writing docs without a visual tool? Build the docs.
I personally build every few paragraphs, not necessarily to check the output, but just to make sure that I did not
make mistakes while writing rST.


Task: Build the documentation
-----------------------------

#. Open a new task file:

   #. Press ``Ctrl-Shift-P``.
   #. Type ``task``.
   #. Select :guilabel:`Tasks: Configure default build task` and select the suggested option. A new file opens containing
      the default skeleton of a task.

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

   Notice the ``command`` field, it contains ``make html``, the Sphinx command to build the HTML output. That's all there is to it.

#. Save.
#. To run it, press ``Ctrl-Shift-B`` and VS Code builds the docs.

   .. note:: If you get another VS Code question about scanning the task output, select :guilabel:`Never scan the task output`.

That's cool, no more window shifting when you want to build but you still have to open your browser and open the page
that you were editing.


Task: Open the output of the current file
-----------------------------------------

The idea of this task is to look at which file is displayed in VS Code, which should be the file you have working on,
and open it in your browser.

#. Open the task file:

   #. Press ``Ctrl-Shift-P``.

   #. Type ``task``.

   #. Select :guilabel:`Tasks: Configure default build task` and select the suggested option.
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

   This file now contains 2 tasks. The first one is the same build command, and the new one labeled ``open page`` runs
   an ``open`` command on the Sphinx build directory, looking for the file that's currently opened in VS code.

   .. note:: The command will probably get confused if you want to open a file that does not have a unique name in your repository
      but aside this case, it's a great time saver.

#. Save.
#. To run it, press ``Ctrl-Shift-B`` and select :guilabel:`open page`, and the page opens in your default browser.

If you find yourself repeating the same actions, think about adding more tasks.