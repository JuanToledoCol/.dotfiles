# Bluetooth

This step for get a connection by **Bluetooth**

## Requirements

- 1. Download the bluez and bluez-utils.
```
sudo pacman -S bluez bluez-utils
```
- 2. Start service of Bluetooth
```
sudo systemctl start bluetooth.service
```
- 3. Enable service for autostart.
```
sudo systemctl enable bluetooth.service
```
- 4. Verify that module **btusb** is charged.
```
lsmod | grep btusb
```
   if not is charged, charge manuall with: ***sudo modprobe btusb***
---
## How use

I use the utility ***bluetoothctl***

- Execute: 
```
bluetoothctl
```

Now, into this utility, you can use:
```
help
scan on                     <- Scan devices
pairable on
pair <device_address>
connect <device_address>    <- Connect to device
disconnect <device_address> <- Disconnet to device
exit                        <- Exit utility
```
---
## Create alias

For enter more speed, i create a alias in ***~/.zshrc*** or ***~/.bashrc***

- Use your editor of preference:
```
nvim ~/.zshrc
```
*search the lines that init on* ***alias***

- Write:
```
alias bt='bluetoothctl'
```

Now when you write bt in console, go to enter in the utility.

