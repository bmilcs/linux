#!/bin/bash
# fstab title
sudo grep -qxF '#bmilcs' /etc/fstab || sudo echo '' >> /etc/fstab
# all unraid entries
sudo grep -qxF 'unraid:' /etc/fstab || sudo echo '' >> /etc/fstab

mount -av
