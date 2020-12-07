#!/bin/bash
echo '====================================================================================================='
echo '====  pihole mods [bmilcs  =========================================================================='
echo '====================================================================================================='

# /var/www/html/admin/scripts/pi-hole/js/queries.js

# find "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
# replace it w/ same + add new line:
#        
#     "stateSave": true,

sed -i '/"lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],/c\\t"lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],\n\t"pageLength": 100,' /var/www/html/admin/scripts/pi-hole/js/queries.js


echo 'zAXnvwcRs8UobjTZGBQKKCt' | tr -d '\n' | sha256sum | cut -d" " -f1
bb12c481344c00cf00db4aa107e6f37ea54fd0f8d17d9653d6475cb19df5ebb4
sed -i "s/^root_password_sha2 =\$/root_password_sha2 = bb12c481344c00cf00db4aa107e6f37ea54fd0f8d17d9653d6475cb19df5ebb4/g" /etc/graylog/server/server.conf
sed -i "s/#root_timezone = UTC/root_timezone = America\/New_York	/g" /etc/graylog/server/server.conf

