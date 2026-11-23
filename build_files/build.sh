#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y oo7-cli
dnf5 install -y greetd
dnf5 install -y vorta
dnf5 install -y kubernetes-client
dnf5 install -y helm
dnf5 install -y wireguard-tools

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# Install Proton utilities
wget https://proton.me/download/mail/linux/1.16.1/ProtonMail-desktop-beta.rpm -O /tmp/proton/ProtonMail.rpm
wget https://proton.me/download/bridge/protonmail-bridge.x86_64.rpm -O /tmp/proton/ProtonMailBridge.rpm
wget https://proton.me/download/pass/linux/proton-pass-1.44.1-1.x86_64.rpm -O /tmp/proton/ProtonPass.rpm
wget https://proton.me/download/meet/linux/1.0.14/ProtonMeet-desktop.rpm -O /tmp/proton/ProtonMeet.rpm

dnf5 install -y /tmp/proton/ProtonMail.rpm
dnf5 install -y /tmp/proton/ProtonMailBridge.rpm
dnf5 install -y /tmp/proton/ProtonPass.rpm
dnf5 install -y /tmp/proton/ProtonMeet.rpm

wget https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=linux&arch=x64&format=rpm -O /tmp/Discord.rpm
dnf5 install -y /tmp/Discord.rpm

# Cleanup

#### Example for enabling a System Unit File

# systemctl enable podman.socket
