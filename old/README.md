## INDEX

1. [Umake](#umake)
4. [Application swithcer](#app_switcher)
5. [Change system's font](#sysfont)
6. [Antivirus for Ubuntu](#antivirus)
7. [Enhenced icon grid view](#eicongridview)
8. [How to change the login screen in Ubuntu 16.04](#loginscreen16)

## UMAKE: COMMAND LINE TOOL FOR DEVELOPERS <a name="umake"></a>

Ubuntu provide a wonderful command line tool, `umake` for developers. `umake` lets you easily install a number of development tools in Ubuntu such as **Android Studio**, **Visual Studio Code**,

**Example: Install PyCharm in Ubuntu using umake**

Installing `umake` utility tool.

```
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
sudo apt-get update
sudo apt-get install ubuntu-make
```

PyCharm Community Edition in Ubuntu:

```
umake ide pycharm
```

To remove PyCharm installed via umake, use the command below:

```
umake -r ide pycharm
```

## UBUNTU 16.04 WEIRD APPLICATION SWITCHER <a name="app_switcher"></a>

Q: After updating uUuntu from 14.04 to 16.04 I've experienced this weird behavior. When I press Alt+Tab, two interfaces show up, the one from unity (the same that showed up when I was using the 14.04), and another that i don't have an idea from where it came from... LOL

A: It's due to Unity and Compiz's application switchers both being enabled with the same keybinding (alt+tab).

You can disable the Compiz Application Switcher by:

1. Installing the Compiz Settings Manager:

```
$ sudo apt install compizconfig-settings-manager
```

2. Open the CompizConfig Settings Manager by launching "ccsm"

3. Select "Window Management"

4. Uncheck "Application Switcher"

Now, only Unity's application switcher (Desktop > Ubuntu Unity Plugin) should appear when you press `alt+tab`.

## CHANGE DEFAULT SYTEM'S FONT <a name="sysfont"></a>

* Download and install any font you like (`DroidSansMono Nerd Font Mono Book` is OK).
* Rebuilding the font cache is not a bad idea

```
$ fc-cache -f -v
```

* Select the font you want to use as default in the system in `Unity tweak tool > Fonts`

## ANTIVIRUS <a name="antivirus"></a>

```
$ sudo apt install clamav
$ sudo freshclam
$ clamscan -r -i <DIR>  # -r: recursive, -i print only infected files
```

## ENHANCED ICON GRID VIEW IN NAUTILUS <a name="eicongridview"></a>

```
$ dconf write /org/gnome/nautilus/icon-view/thumbnail-size 128
$ nautilus -q
$ rm -rf ~/.cache/thumbnails
```

## [HOW TO CHANGE THE LOGIN SCREEN IN UBUNTU 16.04](https://askubuntu.com/a/694370) <a name="loginscreen16"></a>

The proper way of changing default `unity-greeter` background is through overriding `glib-2.0` schema, as specified in the `Lightdm` Ubuntu wiki

The steps are as follows:

* Create `/usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override` file with the following contents:

```
[com.canonical.unity-greeter]
draw-user-backgrounds=false
background='/path/to/wallpaper.png'
```

* Run `sudo glib-compile-schemas /usr/share/glib-2.0/schemas`
* Reboot or login to TTY2 (accessed by pressing `Ctrl+Alt+F2` ) and run `sudo service lightdm restart`


---

Found Windows Boot Manager on /dev/sda1@/EFI/Microsoft/Boot/bootmgfw.efi
Adding boot menu entry for EFI firmware configuration

