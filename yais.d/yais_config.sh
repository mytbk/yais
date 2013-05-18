#!/bin/bash

profile_select(){
	local profile i opt
	local MENU="dialog --stdout --menu \"Profile Selection\" 0 0 0"
	local arr
	i=0
	for profile in "${PROFILEDIR}"/*.sh
	do
		arr=("${arr[@]}" "${profile}")
		MENU="${MENU} ${i} \"$(basename ${profile})\""
		let i=i+1
	done
	opt=$(eval ${MENU}) || true
	[ -n "$opt" ] && cp ${arr[$opt]} ${PROFILE} || true
}

profile_edit(){
	"$EDITOR" ${PROFILE}
}

yais_config(){
	configmenu=("Select a profile" "Edit profile" "Open a bash shell")
	confcmds=(profile_select profile_edit bash)
	local _i opt
	MENU="dialog --stdout --menu \"YAIS ${VERSION}\" 0 0 0"
	for _i in $(seq -s ' ' 0 $((${#configmenu[@]}-1))) 
	do
		MENU="${MENU} ${_i} \"${configmenu[${_i}]}\""
	done
	opt=$(eval ${MENU}) || true
	[ -n "$opt" ] && ${confcmds[$opt]} || true
	echo -n "Source ${PROFILE}..."
	source ${PROFILE} && echo done
}

