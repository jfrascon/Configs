# SAMBA. SHARE FOLDERS BETWEEN LINUX AND WINDOWS 

* Configure in the file `/etc/samba/smb.conf` the folders you want to share.

```
...

[root]
path = /root
read only = no


[home]
path = /home
read only = no


[var]
path = /var
read only = no
```
<img src="01.png" width="75%"/>

* Enable in Windows 10 the Samba service.

<img src="02.png" width="75%"/>

* Map the Linux shared folders as network drives in Windows.

<img src="03.png" width="75%"/>


