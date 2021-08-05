
# dotfiles
Personnal dotfiles


## Installation

```bash
setup.sh
```

## Manual

Compose key :
`Option "XkbOptions" "compose:ralt` > /etc/X11/xorg.conf.d/00-keyboard.conf

Backup solution, in .xinitrc :
```
# compose key
setxkbmap -option compose:ralt
```

Firefox profiles :
```bash
firefox -P
```

