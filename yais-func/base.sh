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
	pacman -Syy && echo -e "\033[32mNetwork OK" || echo -e "\033[31mNetwork failed."
	echo -e "\033[0mPress enter to continue"
	read
}

install_pkg(){
	if [ ! -f /tmp/packages ]; then
		echo "# These are the groups/packages to be installed" >> /tmp/packages
		echo "base base-devel grub-bios" >> /tmp/packages
		echo "# Add the packages you like, remember to uncomment them" >> /tmp/packages
		echo "#vim htop" >> /tmp/packages
	fi
	$EDITOR /tmp/packages
	pacstrap /mnt $(sed -e 's/^[ \t]*//g' -e '/^#/d' /tmp/packages)
}

install_grub(){
	echo -n "The disk you'll install grub on(default /dev/sda):"
	read DISK
	DISK=${DISK:-"/dev/sda"}
	arch-chroot /mnt "grub-install $DISK"
	arch-chroot /mnt "grub-mkconfig -o /boot/grub/grub.cfg"
}

fstab(){
	genfstab /mnt > /mnt/etc/fstab
}

