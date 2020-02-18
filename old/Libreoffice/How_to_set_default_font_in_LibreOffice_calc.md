# [How to set default font in LibreOffice Calc](https://codeyarns.com/2015/05/28/how-to-set-default-font-in-libreoffice-calc/)

**LibreOffice Calc** is an excellent open-source replacement for the popular spreadsheet program Microsoft Excel. One irritation for me is that the default font and font size it uses are not what I would like. To set your own font, font size and other text formatting as default it takes a few steps as described below.

1. Open LibreOffice Calc. It opens with a new spreadsheet document.
2. First, we set our font as default for this spreadsheet document: 

```
Go to Format -> Styles and Formatting.
```

`Right-click` on `Default` and choose `Modify`. In the `Font` tab, set the font, font size and other formatting options that you would like to be the default. Click `OK`.

3. We now save this format as a template: 

```
Go to File -> Templates -> Save As Template.
```

Choose `My Templates` and click `Save`. Give your template a name.

4. Finally, we make our template as the default template:

```
Go to File -> Templates -> Manage
```

In the `Spreadsheets` tab, click on your template and click `Set as default`. We are done! 🙂

All new spreadsheets created by Libreoffice Calc will now have the default font set in this template. Note that this is the font that will also be used for comments in Calc.

Tried with: LibreOffice 4.2.8.2 and Ubuntu 14.04

Thanks Code Yarns!
