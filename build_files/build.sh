#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages from fedora repos
dnf5 install -y oo7-cli
dnf5 install -y greetd
dnf5 install -y vorta
dnf5 install -y kubernetes-client
dnf5 install -y helm
dnf5 install -y wireguard-tools

# Install Proton utilities from downloaded RPMs
wget https://proton.me/download/mail/linux/1.16.1/ProtonMail-desktop-beta.rpm -O /tmp/proton/ProtonMail.rpm
wget https://proton.me/download/bridge/protonmail-bridge.x86_64.rpm -O /tmp/proton/ProtonMailBridge.rpm
wget https://proton.me/download/pass/linux/proton-pass-1.44.1-1.x86_64.rpm -O /tmp/proton/ProtonPass.rpm
wget https://proton.me/download/meet/linux/1.0.14/ProtonMeet-desktop.rpm -O /tmp/proton/ProtonMeet.rpm

dnf5 install -y /tmp/proton/ProtonMail.rpm
dnf5 install -y /tmp/proton/ProtonMailBridge.rpm
dnf5 install -y /tmp/proton/ProtonPass.rpm
dnf5 install -y /tmp/proton/ProtonMeet.rpm

# Install Discord from downloaded RPM
wget 'https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=linux&arch=x64&format=rpm' -O /tmp/Discord.rpm
dnf5 install -y /tmp/Discord.rpm

# Install JetBrains Toolbox from downloaded tar ball
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-3.9.1.89198.tar.gz -O /tmp/jetbrains-toolbox-3.9.1.89198.tar.gz
tar -xvzf /tmp/jetbrains-toolbox-3.9.1.89198.tar.gz -C /usr/share/
ln -s /usr/share/jetbrains-toolbox-3.9.1.89198/bin/jetbrains-toolbox /usr/bin/jetbrains-toolbox

# Install Google Cloud SDK
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz -O /tmp/google-cloud-cli-linux-x86_64.tar.gz
tar -xvzf /tmp/google-cloud-cli-linux-x86_64.tar.gz -C /usr/share/
/usr/share/google-cloud-sdk/install.sh -q
/usr/share/google-cloud-sdk/bin/gcloud components install -q gke-gcloud-auth-plugin
ln -s /usr/share/google-cloud-sdk/bin/gcloud /usr/bin/gcloud

#### Example for enabling a System Unit File

# systemctl enable podman.socket
