editor(){
	echo -n "Your favorate editor(nano,vi,...):"
	read EDITOR
	EDITOR=${EDITOR:-"vi"}
	export EDITOR
}

testnet(){
	pacman -Syy
}

