# Arch Linux 
---
## First step

### Pre-installation

Download **[Arch](https://archlinux.org/download/)**.
Boot ISO arch in a usb.
Start a live usb en your PC.

- Select the first option in the **GRUB.**

---

### Change the keyboard layout:
```bash
loadkeys la-latin1
```

### We connect to wifi: 
```bash
lwctl --passphrase "contraseñaWifi" station wlan0 connect "nombreWifi"

```

Verify the connection:
```bash
ping 8.8.8.8
```

### Update time:
```bash
timedatectl set-ntp true
```

---

# Partitions

Partition of disk:
```bash
lsblk
```
see your partition and then:
```bash
cfdisk /dev/tu_partición_aqui
```

Create 3 partition:

| Size   | Partition Type |
| ---------------| -----------------------|
| **512M** | EFI System        |
| **Your GB of RAM** | SWAP (linux swap)         |
|**REST of GB**| ROOT (linux filesystem) |

Choice to **write**, and write **yes** for save.

Format the disk:
```bash
mkfs.fat -F32 /dev/here_EFI_partition       <-for EFI
mkfs.ext4 /dev/here_ROOT_partition          <-for ROOT
mkswap /dev/here_SWAP_partition            <-for SWAP
```
### Mount the disk:

Crete dir:
```bash
mkdir /mnt/efi
```

and mount;
```bash
mount /dev/aqui_EFI_partition /mnt/efi       <-para EFI
mount /dev/aqui_ROOT_partition /mnt       <-para ROOT
swapon /dev/aqui_SWAP_partition              <-para SWAP
```

---

### Install essentials package:
```bash
pacstrap /mnt base linux linux-firmware neovim iwd
```

---

### Create and enter to fstab:

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

### Execute chroot:
```bash
arch-chroot /mnt
```

### Setting timeZone: 
```bash
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
```

```bash
hwclock –-systohc
```

### Edit localization: 
```bash
nvim /etc/locale.gen
```
 - *Search the next line: **es_CO.UTF-8*** and decomment.

### Create locale.conf:
```bash
nvim /etc/locale.conf
```
- *Write: **LANG=es_CO.UTF-8***

### Setting keyboard:
```bash
nvim /etc/vconsole.conf
```
- *Write: **KEYMAP=la-latin1***

---

### Setting hostname:
```bash
nvim /etc/hostname
```
- *Write a name for your **pc**

### Setting host:
```bash
nvim /etc/hosts
```

```
127.0.0.1     localhost
::1           localhost
127.0.1.1     your_hostname.localdomain    your_hostname
```

- *Write the lines above and replace **'your_hostname'** with the name that you use in the **/etc/hostname**

### Execute initframs:
```bash
mkinitcpio -P
```

---

### Install grub and other packages:
```bash
pacman -S grub base-devel efibootmgr os-prober mtools dosfstools linux-headers networkmanager nm-connection-editor pulseaudio pavucontrol dialog gvfs xdg-user-dirs dhcp
```

### Create dir EFI:
```bash
mkdir /boot/EFI
```
### Monunt the **EFI** partition:
```bash
mount /dev/partition_efi /boot/EFI
```

### Install grub:
```bash
grub-install --target=x86_64-efi –-bootloader-id=grub_uefi –-recheck
```

### Setting grub:
```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

---

### Start NetworkManager y iwd:
```bash
systemctl enable NetworkManager
```

---

### Add new user:
```bash
useradd -m -G wheel juarch
```

### Execute: 
```bash
EDITOR=nvim visudo
```
- ***Uncomment: %wheel ALL=(ALL) ALL and save.*** 

### Write the password for the new user:
```bash
passwd juarch
```

### Setting password for root user:
```bash
passwd root
```

---

### Install driver of display:
For **INTEL**
```bash
pacman -S xf86-video-intel
```
For **AMD**
```bash
pacman -S vulkan-radeon vulkan-icd-loader mesa
```

### Install server of display:
```bash
pacman -S xorg xorg-server xorg-xinit
```

---

## Ready

The system is mount.
only execute
```bash
exit
```
```bash
umount -a
```
```bash
reboot
```

And remove the usb...

When the system reboot, you type the user and password created in console:
---
You need connect to wifi if you don't have a cable Ethernet. Follow the next step:
```bash
# List of networks availables
nmcli device wifi list
# Connect your network
nmcli device wifi connect NAME_WIFI password TU_PASSWORD
```
Test the connection
```bash
ping 8.8.8.8
```
Its all ok.
---
Now let's go to install a tiling window manager **[BSPWM](Bspwm.md)**.
