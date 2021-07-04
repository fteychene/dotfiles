
# dotfiles
Personnal dotfiles


Compose key :
`Option "XkbOptions" "compose:ralt` > /etc/X11/xorg.conf.d/00-keyboard.conf

Backup solution, in .xinitrc :
```
# compose key
setxkbmap -option compose:ralt
```