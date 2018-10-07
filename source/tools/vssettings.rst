.. _vscode-config:

Settings
========

The settings for VS Code partly depend on the extensions that you installed, but here are some recommended
core settings. To you use them:

#. Press ``Cmd+Shift+P`` and type ``settings`` and select :guilabel:`Preferences: Open User Settings`.
#. The most important thing in the core settings is the ruler position. I set mine at 114 which helps for GitHub
   reviews since it's the maximum number of characters on one line.

   Paste the following settings into the settings window.

   .. code-block:: json

    {
        "editor.detectIndentation": true,
        "editor.minimap.enabled": false,
        "editor.renderIndentGuides": true,
        "editor.scrollBeyondLastLine": false,
        "editor.tabSize": 2,
        "editor.useTabStops": false,
        "editor.rulers": [
            114
        ],
        "editor.wordWrapColumn": 114,
        "explorer.confirmDelete": false,
        "explorer.confirmDragAndDrop": false,
        "files.trimTrailingWhitespace": true,
        "git.confirmSync": false,
        "git.enableSmartCommit": true,
        "git.autofetch": true,
        "window.title": "${activeEditorLong}${separator}${rootName}",
        "restructuredtext.linter.run": "off",
        "workbench.editor.enablePreview": false,
        "workbench.editor.enablePreviewFromQuickOpen": false,
        "workbench.editor.showTabs": true,
        "workbench.startupEditor": "welcomePage"
    }


.. tip:: If you use the VIM plugin, you can also set the line size to 114 (``"vim.textwidth": 114``). This
         allows you to use the auto line formatting feature by selecting a paragraph and hitting ``gq`` in normal
         mode.
