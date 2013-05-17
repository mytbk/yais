editor(){
	EDITOR=$(dialog --stdout --inputbox "Your favorite editor" 0 0 vi)
	export EDITOR
}

testnet(){
	pacman -Sy && echo -e "\033[32mNetwork OK" || echo -e "\033[31mNetwork failed."
	echo -e "\033[0mPress enter to continue"
	read
}

install_grub(){
	echo -n "The disk you'll install grub on(default /dev/sda):"
	read DISK
	DISK=${DISK:-"/dev/sda"}
	arch-chroot ${ROOTDIR} grub-install $DISK
	arch-chroot ${ROOTDIR} grub-mkconfig -o /boot/grub/grub.cfg
	echo -e "\033[32mGRUB installed, press enter to continue\033[0m"
	read
}

fstab(){
	genfstab ${ROOTDIR} > ${ROOTDIR}/etc/fstab
	echo -e "\033[32mgenfstab ok, press enter to edit your fstab\033[0m"
	read
	$EDITOR ${ROOTDIR}/etc/fstab	
}

setpass(){
	arch-chroot ${ROOTDIR} passwd
}

yais_chroot(){
	arch-chroot ${ROOTDIR} /bin/bash
}

