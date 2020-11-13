#!/bin/bash


mdadm -E /dev/sd{b,c,d,e}


parted --script /dev/sdb mklabel msdos -- mkpart primary 1MiB -1s \
    set 1 raid on
parted --script /dev/sdc mklabel msdos -- mkpart primary 1MiB -1s \
    set 1 raid on
parted --script /dev/sdd mklabel msdos -- mkpart primary 1MiB -1s \
    set 1 raid on
parted --script /dev/sde mklabel msdos -- mkpart primary 1MiB -1s \
    set 1 raid on

yes | mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/sd[b-e]1
#mkfs.xfs /dev/md0

parted --script /dev/md0 mklabel gpt -- mkpart primary 1MiB 200MiB \
        mkpart primary 200MiB 400MiB \
        mkpart primary 400MiB 600MiB \
        mkpart primary 600MiB 800MiB \
        mkpart primary 800MiB 820MiB

