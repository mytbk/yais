MIRROR=http://mirrors.tuna.tsinghua.edu.cn/debian
INSTALLPKG="grub-pc,vim,htop,build-essential"
OPTION="--include=${INSTALLPKG}"
SUITE=stable

pkgstrap(){
	debootstrap ${OPTION} ${SUITE} ${ROOTDIR} ${MIRROR}
}

mirrorselect(){
	MIRROR=$(dialog --stdout --inputbox "Debian mirror" 0 0 "${MIRROR}")
}

