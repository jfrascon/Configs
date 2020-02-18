# [HOW TO USE CPPCHECK WITH ECLIPSE CDT](https://codeyarns.com/2015/06/11/how-to-use-cppcheck-with-eclipse-cdt/)

The biggest problem of C++ code is bugs. Bugs can slip through even when compiling code with all warnings turned on. A useful tool in the arsenal of a C++ programmer is `cppcheck`, a static analysis tool. You are in luck if you are using Eclipse CDT because the `cppcheclipse` plugin makes using `cppcheck` with your C++ project very easy.

1. First [install CPPCheck](http://cppcheck.sourceforge.net/):  
Linux Debian/Ubuntu:  
`$ sudo apt-get install cppcheck`  
Linux Fedora/RH  
`$ sudo yum install cppcheck`  
MacOS:  
`$ brew install cppcheck`  
Windows:  
[Installers](http://cppcheck.sourceforge.net/)  
2. Install `cppcheclipse` in Eclipse CDT by choosing one of the methods below:  
    1. Automatic: The easiest way to install is via `Eclipse Marketplace` which is integrated into Eclipse since 3.6 (Helios).  
        1. Click on `Help->Eclipse Marketplace...`  
        2. Enter `cppcheclipse` in the Find field and click on `Go`  
        3. Click on the `Install` button beneath the entry for `cppcheclipse`.
    2. Manually add `Eclipse Update Site`.  
        1. Click on `Help->Install New Software...`  
        2. Add the new Update Site `https://dl.bintray.com/cppcheclipse/p2/updates/`  
        3. Uncheck `Group items by category`  
        4. Select `cppcheclipse` and click on `Next`  
        5. Follow the installation wizard, until installation is completed.  
        6. Restart Eclipse   
3. Configure `cppcheclipse`:
    1. Go to `Window -> Preferences -> C/C++ -> CPPChEclipse`.   
    2. First, set the path of `cppcheck` to `/usr/bin/cppcheck` (In MacOS you get that path using `$ brew --prefix=cppcheck`).  
    3. Go to [`settings`](https://github.com/kwin/cppcheclipse/wiki/WorkspacePreferences#Settings) and select the checks you want to execute (default is to check only for problems).  
       You can also indicate to `cppcheck` to use the include paths used by your project (this is very useful).  
       `cppcheclipse` checks automatically for updates of `cppcheck`. This behaviour can be configured via the `Eclipse Preferences->C/C++->cppcheclipse`.  
       To update `cppcheclipse` itself, go to `Help->Check for Updates`.  
       (To see more about configuration options click [here](https://github.com/kwin/cppcheclipse/wiki/WorkspacePreferences#General))   
       (To configure cppcheck specificly for a project, overwriting some of the settings in the project properties, click [here](https://github.com/kwin/cppcheclipse/wiki/ProjectProperties))  
    4. Go to [`problems`](https://github.com/kwin/cppcheclipse/wiki/WorkspacePreferences#Problems) and deselect the issues you want to suppress (warnings, errors, style problems).  
    5. Click on `OK`.     
4. You can check a file with `cppcheck` in different ways:  
    1. Automatically check a file, whenever it is built (must be enabled in the [project properties](https://github.com/kwin/cppcheclipse/wiki/ProjectProperties#Build)).  
    2. Manually check a file via the entry `CPPCheck -> Run CPPCheck` in the context menu on either the package/project explorer or within the C editor.  
    3. Manually check a file via the shortcut `Ctrl+Shift+C` (MacOS: `Cmd+Shift+C`).  

   All issues detected by `cppcheck` are reported in the `Problems` view of Eclipse.  
   Additionally to that you can see the original output of `cppcheck` in the console view.  
