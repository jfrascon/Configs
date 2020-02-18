# [HOW TO GET RELATIVE LINE NUMBERS IN ECLIPSE](https://codeyarns.com/2015/05/21/how-to-get-relative-line-numbers-in-eclipse/)

![Image 1](https://github.com/jfrascon/CONFIG_FILES/blob/master/ECLIPSE/IMAGES/20150521_relative_number_0.png)

Being able to view [relative line numbers](https://codeyarns.com/2015/05/21/how-to-get-relative-line-numbers-in-eclipse/2015/03/24/absolute-relative-and-hybrid-line-numbers-in-vim/) in Vim makes it very easy to move around and operate in the editor. This is because a lot of Vim commands involve line counts that are relative to the current line.

If you are using Vrapper in Eclipse, you might be missing having relative line numbers. It is possible to get them by installing the [Relative Number Ruler](https://github.com/matf/relativenumberruler) plugin.

## INSTALL

* To install, go to Help -> Install New Software -> Add and use the URL http://matf.github.io/relativenumberruler/updatesite/
* If you do not see any plugins show up, uncheck the “Group items by category” option at the bottom of the dialog.
* You should be able to choose the plugin and install it from there.

## USAGE

![Image 1](https://github.com/jfrascon/CONFIG_FILES/blob/master/ECLIPSE/IMAGES/20150521_relative_number_1.png)

* Right-click on the line number ruler, this is the editor column where the line numbers are displayed. From here, you can enable or disable both line numbers and relative line numbers.

* If you would like to have the hybrid mode, where the current line shows the absolute line number and the rest show relative line numbers, that is supported too. Go to Window -> Preferences -> Relative Number Ruler and enable this feature.

Thanks Code Yarns, again :)
