# Grub

## Customize your grub

- Dowload the theme that your want apply to grub.

*I Recommend [Gnome-look](https://www.gnome-look.org/browse?cat=109)*

1. Select your theme
2. Download the **tar.xz** or **.zip**
3. Go to dir of dowmloads.
4. Extract the folder download.

Now go to copy the new folder extracted into the next PATH
- */boot/grub/themes/*

open your terminal and copy and paste the next line:
```
sudo cp -r ~/your_folder_downloads_dir/the_name_of_extracted_folder /boot/grub/themes/ 
```
---

### BackUp

We need a backup of file */etc/default/grub* in case something goes wrong.
execute the next lines:
```
cd /etc/default/
sudo cp grub grup.backup
```

And now change some properties in */etc/default/grub*
1. Open the file grub in your terminal:
```
sudo nvim /etc/default/grub 
```
2. Search the line:
```
GRUB_GFXMODE=auto
```
*We need change ***auto*** for our display.*
if you don't know what is, execute:
    ```
    xrandr
    ```
and copy the resolution that have a '*'.

In my case the line would be:
```
GRUB_GFXMODE=1366x768
```
3. Now search the next line:
```
GRUB_THEME="/path/to/gfxtheme"
```
here you paste the path where copy the theme and go to file *theme.txt*
In my case the line would be:
```
GRUB_THEME="/boot/grub/themes/xenlism-grub-arch-1080p/Xenlism-Arch/theme.txt"
```

4. The last step is, regenerate the file */boot/grub/grub.cfg* with the next line:
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Now reboot the SO and enjoy your new GRUB.
