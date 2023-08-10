#!/bin/bash

# Defaults
declare -A ALL
crypted=()
BACKUP_DIR="$HOME/backups/"
CU='\033[0;32m' # Colour for Update (green)
CC='\033[0;31m' # Colour for Crypted (red)
NC='\033[0m' # No Colour

[[ -v $XDG_CONFIG_HOME ]] && source $XDG_CONFIG_HOME/backups.conf || source $HOME/.config/backups.conf


read -sp "password: " passwd && printf "\n"

for name in "${!ALL[@]}"
do

    # turn e.g. "/etc/fstab;/etc/rc.conf" into
    # array ("/etc/fstab" "/etc/rc.conf")
    IFS=";" read -r -a files <<< "${ALL[$name]}"

    #declare regex_name="\<${name}\>"

    #if [[ " ${crypted[@]} " =~ " ${regex_name} " ]] ; then
    if [[ " ${crypted[@]} " == *" $name "* ]] ; then
	    (cd $BACKUP_DIR && zip -qureP $passwd $name.zip ${files[@]}) \
	        && printf "${CU}$name: ${files[*]} ${CC}(crypted)${NC}\n" \
	        || printf "$name: ${files[*]} ${CC}(crypted)${NC}\n"
    else
	    (cd $BACKUP_DIR && zip -qur $name.zip ${files[@]}) \
	        && printf "${CU}$name: ${files[*]}${NC}\n" \
	        || printf "$name: ${files[*]}\n"
    fi
done

