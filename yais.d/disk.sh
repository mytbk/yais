mount_read(){
#some hard code to support swap
	if [ "$2" = "swap" ]; then
		if [ "$3" = "swap" ]; then
			echo -e "\033[31m$1 will be formatted!\033[0m Continue?(y/n)"
			read ANS
			shopt -s nocasematch
			if [ ${ANS} = "y" ]; then
				mkswap $1
			fi
			shopt -u nocasematch
		fi
		echo "To mount $1 as swap."
		swapon $1
		return
	fi

	if [ -n "$3" ]; then
		echo -e "\033[31m$1 will be formatted!\033[0m Continue?(y/n)"
		read ANS
		shopt -s nocasematch
		if [ ${ANS} = "y" ]; then
			mkfs.$3 -q $1
		fi
		shopt -u nocasematch
	fi
	echo "mount $1 ${ROOTDIR}$2"
	if [ ! -d ${ROOTDIR}$2 ]; then
		mkdir -p ${ROOTDIR}$2
	fi
	mount $1 ${ROOTDIR}$2
}

mount_disk(){ 
	#read the mounttab file
	#mount_disk <dev> <mountpoint> <fs>
	[ -f /tmp/mounttab ] || cp /etc/yais.d/mounttab.example /tmp/mounttab
	$EDITOR /tmp/mounttab
	sed \
		-e 's/^[ \t]*//g' \
		-e '/^#/d' \
		-e '/^$/d' \
		/tmp/mounttab|sort -k 2,2 > /tmp/mount.tmp
	WC=$(wc -l</tmp/mount.tmp)
	NLINE=0
	while [ ${NLINE} -lt ${WC} ]
	do
		let NLINE++
		mount_read $(head -n$NLINE /tmp/mount.tmp|tail -n1)
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
	echo -e "\033[33mNote that your partitions are not formatted.\033[0m"
	echo "Press enter to continue"
	read
}

