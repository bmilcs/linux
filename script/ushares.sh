#!/bin/bash
# fstab title
sed -i '/unraid:/d' /etc/fstab
sed -i '/#bmilcs/d' /etc/fstab
echo
echo '====================================================================================================='
echo '====  removed network shares  ======================================================================='
echo '====================================================================================================='
echo
echo
cat /etc/fstab
echo
echo '----  done  -------------------------------------------------------------------------------------------'
echo
