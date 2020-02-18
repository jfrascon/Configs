# PYDEV TOPICS

## [HOW TO INSTALL PYDEV](https://codeyarns.com/2014/12/23/how-to-manually-install-pydev/2014/12/23/how-to-install-pydev/)

**PyDev** brings support for working with Python files to **Eclipse**. Installing the PyDev plugin for Eclipse is very easy:

1. `Go to Help -> Install New Software`.
2. Click on `Add` and add `http://pydev.org/updates` if you want the stable version or `http://pydev.org/nightly` if you want the bleeding edge versions.
3. PyDev appears in the list below, choose it and follow through the dialog, giving it install permissions and it will be installed. You will need to restart Eclipse to use PyDev.

## [HOW TO MANUALLY INSTALL PYDEV](https://codeyarns.com/2014/12/23/how-to-manually-install-pydev/)

The easiest and recommended method to install PyDev is to use `Install New Software` as shown above. Sometimes this method gives the following error:

```
An error occurred while collecting items to be installed
session context was:(profile=epp.package.cpp, phase=org.eclipse.equinox.internal.p2.engine.phases.Collect, operand=, action=).
Unable to read repository at http://pydev.org/updates/plugins/com.python.pydev.debug_3.9.0.201411111611.jar.
Read timed out
Unable to read repository at http://pydev.org/updates/plugins/org.python.pydev.help_3.9.0.201411111611.jar.
Read timed out
```

Thankfully, PyDev plugin can be installed manually and that is what I ended up doing:

1. Download the latest plugin zip files from [here](http://sourceforge.net/projects/pydev/files/).
2. Unzip the file and you get two directories features and plugins. Place these directories in the dropins directory of your Eclipse installation.
3. Restart Eclipse if it was running.
4. Go to `Help -> Installation Details`. You should be able to find PyDev listed here.

You should be able to use PyDev now! 🙂

## [HOW TO ADD PYTHON 3 AS AN INTERPRETER IN PYDEV](https://codeyarns.com/2015/01/08/how-to-add-python-3-as-interpreter-in-eclipse/)

The PyDev plugin adds support for working with Python files to Eclipse. However, it is only auto-configured to work with a Python 2.x interpreter.

To use Python 3.x for your Python files in Eclipse:

1. First install `Python 3.x` (for example, using the Anaconda distribution)
2. In Eclipse, open `Preferences -> PyDev -> Interpreters -> Python Interpreter`. Click New and add `/Users/<your_user>/anaconda3/bin/python3. The Libraries and other settings will be auto-discovered by PyDev.

That is it! When you create a new Python project, in its dialog remember to pick Grammar version as 3.0 and the Interpreter as Python3.

Thanks Code Yarns, ;P
