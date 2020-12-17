
# Table of Contents

1.  [Work in progress](#org03e64fd)
    1.  [Gnome-related](#orgdcee511)
        1.  [Desktop customization](#org2c22866)
        2.  [Tilix](#org0ba5b66)
    2.  [Doom Emacs](#orgb3701fa)
        1.  [config](#org4a4f433)
    3.  [Programming Languages](#orgac1b610)
        1.  [Scheme](#orgb959f8f)
        2.  [Python](#orgb32d2c1)
        3.  [Go](#org3bb727f)
        4.  [JavaScript](#org4f01a5f)
    4.  [Docker](#orge6e4a0a)
    5.  [Fish Shell](#orga7cc94a)
    6.  [Browsers](#orgaeceeb9)
        1.  [Firefox](#orgb4c0794)
        2.  [Chromium](#orga41ee9b)
    7.  [Educational Software](#org2ea7f07)
        1.  [Anki](#orge3d3461)
        2.  [Zotero](#orgfb601bb)
    8.  [Extras](#org6ce018c)
    9.  [Mounts](#orgeb65f36)
    10. [Backup & Sync](#org2a94190)
        1.  [Syncthing](#org51a51df)
        2.  [`borg`](#org7fe70ef)
    11. [Hardening](#orgdf6fc13)
        1.  [Mullvad VPN](#org5bb38bd)
        2.  [Create AppArmor profiles for all network-enabled apps](#org55c3b71)
        3.  [Go through suggestions in this article and this one](#org159abfb)

A simply playbook that sets up my Debian 11 workstation just the way I like it
from a slim netinstall that you can get from here. You can find the weekly
builds here:

https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/

Here is how you verify them. First import the debian keys

``` bash
import debian k
```

Simply comment out the roles which are unnecessary for your use case in
`site.yml`.

install `openssh` on target and you're ready to rumble.


<a id="org03e64fd"></a>

# Work in progress


<a id="orgdcee511"></a>

## DONE Gnome-related


<a id="org2c22866"></a>

### DONE Desktop customization

1.  [X] Keyboard Shortcuts

2.  [X] tar theme and icons to unclutter repo


<a id="org0ba5b66"></a>

### [X] Tilix


<a id="orgb3701fa"></a>

## DONE Doom Emacs


<a id="org4a4f433"></a>

### [X] config


<a id="orgac1b610"></a>

## DONE Programming Languages


<a id="orgb959f8f"></a>

### [X] Scheme


<a id="orgb32d2c1"></a>

### [X] Python

1.  [ ] Install pyenv virtualenv


<a id="org3bb727f"></a>

### [X] Go


<a id="org4f01a5f"></a>

### [X] JavaScript


<a id="orge6e4a0a"></a>

## DONE Docker


<a id="orga7cc94a"></a>

## DONE Fish Shell


<a id="orgaeceeb9"></a>

## DONE Browsers


<a id="orgb4c0794"></a>

### [X] Firefox


<a id="orga41ee9b"></a>

### [X] Chromium


<a id="org2ea7f07"></a>

## DONE Educational Software


<a id="orge3d3461"></a>

### DONE Anki


<a id="orgfb601bb"></a>

### DONE Zotero


<a id="org6ce018c"></a>

## DONE Extras


<a id="orgeb65f36"></a>

## DONE Mounts


<a id="org2a94190"></a>

## DONE Backup & Sync


<a id="org51a51df"></a>

### DONE Syncthing


<a id="org7fe70ef"></a>

### DONE `borg`


<a id="orgdf6fc13"></a>

## TODO Hardening


<a id="org5bb38bd"></a>

### DONE Mullvad VPN


<a id="org55c3b71"></a>

### TODO Create AppArmor profiles for all network-enabled apps


<a id="org159abfb"></a>

### TODO Go through suggestions in [this article](https://www.kuketz-blog.de/sicheres-desktop-system-linux-haerten-teil1/) and [this one](https://pvera.net/posts/apparmor-firejail-sandboxing/)

