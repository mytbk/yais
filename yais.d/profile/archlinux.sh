INSTALLPKG="grub-bios vim htop"

pkgstrap(){
	pacstrap ${ROOTDIR} ${INSTALLPKG}
}

mirrorselect(){
	$EDITOR /etc/pacman.d/mirrorlist
}
