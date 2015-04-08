#!/usr/bin/env bash

set -e 

echo "[mkimage-rabbitmq.sh]: Building RabbitMQ fs."

cd $(dirname "${BASH_SOURCE[0]}")

# Update pacman and install required packages
rm -f /var/lib/pacman/db.lck
sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf
pacman -Syy && pacman -Syu --noconfirm && pacman-db-upgrade
pacman -S --noconfirm --needed erlang-nox base-devel

# Make build dir
mkdir /home/build
cd $_

# Get package
curl -SL https://aur.archlinux.org/packages/ra/rabbitmq/rabbitmq.tar.gz | tar xz
cd rabbitmq

# Allow user nobody to makepkg
chgrp nobody . 
chmod g+ws . 
setfacl -m u::rwx,g::rwx . 
setfacl -d --set u::rwx,g::rwx,o::- .

# Make
sudo -u nobody makepkg --skippgpcheck

# Set permissions
chmod -R 750 /usr/share/

# Install
pacman -U rabbitmq-3.5.0-1-x86_64.pkg.tar.xz --noconfirm

ROOTFS=$(mktemp -d /rabbitmqfs-archlinux-XXXXXXXXXX)
chmod 755 $ROOTFS

# Rebuild dev (udev doesn't work in containers)
DEV=$ROOTFS/dev
rm -rf $DEV
mkdir -p $DEV
mknod -m 666 $DEV/null c 1 3
mknod -m 666 $DEV/zero c 1 5
mknod -m 666 $DEV/random c 1 8
mknod -m 666 $DEV/urandom c 1 9
mkdir -m 755 $DEV/pts
mkdir -m 1777 $DEV/shm
mknod -m 666 $DEV/tty c 5 0
mknod -m 600 $DEV/console c 5 1
mknod -m 666 $DEV/tty0 c 4 0
mknod -m 666 $DEV/full c 1 7
mknod -m 600 $DEV/initctl p
mknod -m 666 $DEV/ptmx c 5 2
ln -sf /proc/self/fd $DEV/fd

# Compress fs
rm -rf /opt/shared/rabbitmq-fs.tar.xz
mkdir -p /opt/shared
tar --xz -f /opt/shared/rabbitmq-fs.tar.xz --numeric-owner -C $ROOTFS -c . 
rm -rf $ROOTFS

echo "[mkimage-rabbitmq.sh]: Image build completed."