# KDE Dots Repo
*My KDE + Arch workstation configuration repo*

## Pre-install
`iwctl` - Internet

`pacman -Sy` - Sync repos

`archinstall` - Cause we lazy -> Any option not specified below can be left blank or up to the users discretion

- Disk configuration = default partition layout -> ext4
- Disk encryption = Set password -> Encryption type: Luks -> Partitions: /
- Profile = Type: Desktop (KDE Plasma) -> Graphics Driver: Best for your hardware
- Audio = Pipewire
- Additional packages = networkmanager git
- Network configuration = Use Networkmanager
 
## Post-install
`besmart.sh -a`

`sudo reboot now`
