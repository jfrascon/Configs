# [Build Project keyboard shortcut in Eclipse CDT](https://codeyarns.com/2013/09/29/build-project-keyboard-shortcut-in-eclipse-cdt/)

**Eclipse CDT** and **NSight Eclipse Edition** both do not have a default keyboard shortcut for **Build Project**. They do have `C-B` for **Build All**, which builds all the projects in the Workspace. This is a surprising omission considering how frequently Build Project needs to be used by a C++ developer.

You can assign a new keyboard shortcut for Build Project, by going to

```
Window > Preferences > General > Keys.
```

On my computers, I just remove the Ctrl + B shortcut for Build All and assign it to Build Project.

Tried with: Eclipse 3.7.2, Eclipse CDT 8.0.2 and Ubuntu 12.04 LTS

Thanks Code Yarns! ;P
