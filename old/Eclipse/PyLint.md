## [HOW TO INSTALL PYLINT IN ECLIPSE](https://codeyarns.com/2015/01/02/how-to-use-pylint-for-eclipse/)

Eclipse can be used to work with Python files by installing the PyDev plugin (by pulling it online or manually as shown above). **PyLint** can be used to improve the quality of Python code and to ensure it complies with [PEP 8 guidelines](https://www.python.org/dev/peps/pep-0008/).

To enable and use PyLint in Eclipse:

1. Install PyLint for Python 3.x.
2. Go to `Eclipse -> Preferences -> PyDev -> Editor -> Code Analysis -> PyLint`.
3. Enable the Use PyLint option.
4. By default, the output of PyLint is displayed as text in the Console view. Instead, the problems found by PyLint can be marked as errors or warnings in your editor window and listed in the Problems view. These options can be set in the same dialog.
5. Add the path to the PyLint executable. `PyLint to use: [X] Specify Location`
6. Choose how you want the various problems reported by PyLint to be reported as: error, warning or information.
7. Click `Apply`, then `OK`.
8. Restart Eclipse.

Now whenever you save a Python file, PyLint is executed. Its output is either shown in the Console view or marked out in the Editor and shown in the Problems view.

**Note**: If PyLint does not execute when you save a Python file, see the next entry on how to fix this issue.

Thanks Code Yarns ;P

## [PYLINT NOT RUNNING IN ECLIPSE](https://codeyarns.com/2015/01/02/pylint-not-running-in-eclipse/)

**PyLint** in Eclipse is not being executed when you save a Python file open in the Editor.

**Solution**

1. Add the directory that contains the source file to `Project -> Properties -> PyDev – PYTHONPATH -> Source Folders`.
2. Restart Eclipse.

PyLint should work after this.

Thanks Code Yarns ;P
