editor(){
	echo -n "Your favorate editor(nano,vi,...):"
	read EDITOR
	EDITOR=${EDITOR:-"vi"}
	export EDITOR
}

mirrorselect(){
	$EDITOR /etc/pacman.d/mirrorlist
}

testnet(){
	pacman -Sy && echo -e "\033[32mNetwork OK" || echo -e "\033[31mNetwork failed."
	echo -e "\033[0mPress enter to continue"
	read
}

install_pkg(){
	[ -f /tmp/packages ] || cp /etc/yais.d/packages.example /tmp/packages
	$EDITOR /tmp/packages
	pacstrap ${ROOTDIR} $(sed -e 's/^[ \t]*//g' -e '/^#/d' /tmp/packages)
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

