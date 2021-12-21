```
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Born2BeRoot_Documentation.md                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sel-kham <sel-kham@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/21 03:08:45 by sel-kham          #+#    #+#              #
#    Updated: 2021/12/21 04:44:32 by sel-kham         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
```
## Born2BeRoot
> This section is for **42Network** cursus, if you are not a **42Network** student you don't have to follow these instructions, and you can set you prefered configuration.
### Installation:
* You can follow this [video](https://www.youtube.com/watch?v=2w-2MX5QrQw) for the whole installation proccess.
### Basic configuration:
#### SUDO
1. Switch to root user: ```su -``` Or ```su root```.
2. Install **sudo**: ```apt install sudo -y```.
    - **apt**: Advanced Package Tool, or APT, is a free-software user interface that works with core libraries to handle the installation and removal of software on Debian, and Debian-based Linux distributions. [Wikipedia](https://en.wikipedia.org/wiki/APT_(software)).
    - **sudo**: Or "**s**ubstitute **u**ser, **do**", is a program for Unix-like computer operating systems that enables users to run programs with the security privileges of another user, by default the superuser. [Wikipedia](https://en.wikipedia.org/wiki/Sudo).
2. Install **usermod**: ```apt install usermod -y```
    - **usermod**: The usermod command modifies the system account files to reflect the changes that are specified on the command line. [man page](https://linux.die.net/man/8/usermod).
3. Add your user to sudo group: ```sudo usermod -aG sudo <username>```.
    - **-aG**: The flags for *usermod* command, [RTFM](https://linux.die.net/man/8/usermod) for more information.
    - **sudo**: The group that you need to add the user to (sudo in our example).
    - **username**: The user which will be added to the specified group.
4. Protect sudo and root privileges: ```touch sudoers_config && echo "Default rootpw" >> /etc/sudoers.d/sudoers_config```
    - By default, when you type *sudo + some_cmd* as a normal user, you are required to enter your own password. This command is for protecting sudo access by requesting root password.
    - **This step is not required in Born2beroot subject**!
#### SSH
* **Secure Shell (SSH)**, refers to the protocol by which network communications can take place safely and remotely via an unsecured network. [More](https://www.n-able.com/blog/ssh-network-protocol-overview)