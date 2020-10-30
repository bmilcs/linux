# #!/bin/bash

## if file exists

	if [ -f ~/file ]; then
		yupp
	fi



## check if nfs is mounted / fstab

	#!/bin/bash
	mount="/myfilesystem"

	if grep -qs "$mount" /proc/mounts; then
		echo "It's mounted."
	else
		echo "It's not mounted."
		mount "$mount"
		if [ $? -eq 0 ]; then
		echo "Mount success!"
		else
		echo "Something went wrong with the mount..."
		fi
	fi