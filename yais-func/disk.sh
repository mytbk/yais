mount_read(){
	echo "mount $1 /mnt$2"
	if [ ! -d /mnt$2 ]; then
		mkdir -p /mnt$2
	fi
	mount $1 /mnt$2
}

mount_disk(){ 
	#read the mounttab file
	#mount_disk <dev> <mountpoint>
	if [ ! -f /tmp/mounttab ]; then
		echo "# examples:" > /tmp/mounttab
		echo "# /dev/sda5 /" >> /tmp/mounttab
		echo "# /dev/sda1 /boot" >> /tmp/mounttab
	fi
	$EDITOR /tmp/mounttab
	sed \
		-e '/^#/d' \
		-e 's/^[ \t]*//g' \
		-e '/^$/d' \
		/tmp/mounttab|sort -k 2,2 > /tmp/mount.tmp
	cat /tmp/mount.tmp|while read LINE
	do
		mount_read $LINE
	done
}

partition(){
	OPTIONS=(fdisk cfdisk parted gparted)
	echo -n "The disk you'll partition(default /dev/sda):"
	read DISK
	DISK=${DISK:-"/dev/sda"}
	echo -e "\033[32mSelect a tool to partition your disk:\033[0m"
	for i in {0..3}
	do
		echo "$i. ${OPTIONS[$i]}"
	done
	read TOOLID
	${OPTIONS[$TOOLID]} ${DISK}
	echo "If you have not formatted your partitions,"
	echo "you can open a shell to mkfs your partitions."
}

