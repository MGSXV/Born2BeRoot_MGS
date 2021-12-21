```
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Installing_The_Machine.md                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sel-kham <sel-kham@student.42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/21 00:59:37 by sel-kham          #+#    #+#              #
#    Updated: 2021/12/21 00:59:37 by sel-kham         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
```
## Setting up VirtualBox

1. Go to New to create a  new VM on **VirtualBox**.
    - Name: Pick a descriptive name.
    - Machie Folder: Choose the folder for you VM.
    - Choose: Choose **Linux**.
    - Version: Debia 32-bit or 64-bit (Depending on your system).
2. Memory size: To select the RAM to be allocated (1024MB or more is recommended).
3. Hard disk :
    -   Do not add a virtual hard disk.
    > VHD (Virtual Hard Disk).
    -   Use an existing virtual hard disk.
4. Hard disk file type:
    - \> VDI (VirtualBox Disk Image).
    -   VHD (Virtual Hard Disk).
    -   VMDK (Virtual Machine Disk).
5. Storage on physical hard disk:
    - \> Dynamically allocated.
    -   Fixed size.
6. File location and size:
    - Choose the directory which will store the VDI file.
    - Select the size of the virtual hard disk (20GB or more is recommended).
7. Go to settings -> Storage -> Controller: IDE -> Empty -> Attributes -> Optical Drive:
    - Choose the Debian ISO file by clicking on the "CD" icon.
8. Go to Start to boot your VM.
