#!/bin/bash

    # Copyright(C) 2012 Koustubh Sinkar 
     
    # This program is free software: you can redistribute it and/or modify
    # it under the terms of the GNU General Public License as published by
    # the Free Software Foundation, either version 3 of the License, or
    # (at your option) any later version.
     
    # This program is distributed in the hope that it will be useful,
    # but WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    # GNU General Public License for more details.
     
    # You should have received a copy of the GNU General Public License
    # along with this program.  If not, see <http://www.gnu.org/licenses/

usage="\nUSAGE:\t\t ./initiation.sh [options]\nDESCRIPTION:\t This script is for creating the default development setup preferred by Koustubh Sinkar on any *nix computer that he setups\n\nOPTIONS:\n\t -x <username>\t does the installation for the user specified\n\t -h \t\t displays this help"

while getopts "x:h" opt; do
    case $opt in
	x)	    
	    user=`whoami`
	    if [ $user != "root" ]; then
		echo -e 'You are not su. Please login as root and rerun the script.\n'
		exit
	    fi

	    local_user=$OPTARG
	    does_user_exist=`cat /etc/passwd | grep $local_user`

	    if [[ ! $does_user_exist =~ $local_user ]]; then
		echo "The user "$local_user" does not currently exist on your system."
		exit
	    fi
	    
            # Declaring all the regex to be required later
	    linux="[Ll]inux"
	    debian="[Dd]ebian"
	    ubuntu="[Uu]buntu"
	    fedora="[Ff]edora"
	    redhat="[Rr]edhat"
	    centos="[Cc]entos"

	    distribution=`cat /etc/*release`

	    if [[ $distribution =~ $fedora ]]; then
                rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
                yum install -y freeworld-freetype
                install_command="yum install -y"
	    elif [[ $distribution =~ $redhat ]] || [[ $distribution =~ $centos ]]; then
	        install_command="yum install -y"
	    elif [[ $distribution =~ $ubuntu ]] || [[ $distribution =~ $debian ]]; then
	        apt-get update --assume-yes
	        install_command="apt-get install --assume-yes"
	    else
		echo -e "UNKNOWN DISTRIBUTION\n Exiting NOW!"    
		exit
	    fi

	    basics="N"
	    embedded="N"
	    software="N"
	    web="N"
	    publish_design="N"
	    
	    echo 'Which packages would you like to setup?'
	    read -p '1. Basic Necessities: [y/N] ' basics
	    read -p '2. Embedded Systems Development: [y/N] ' embedded
	    read -p '3. Software Development: [y/N] ' software
	    read -p '4. Web Development: [y/N] ' web
	    read -p '5. Publishing and Designing: [y/N] ' publish_design
	    
	    basics_list="emacs vlc byobu vim git"
	    embedded_list="geda icarus vhdl iverilog gwave makehuman gerbv kicad alliance"
	    software_list="fpc gcc-arm gcl clisp cmucl grass octave"
	    web_list="Django wordpress drupal"
	    publish_design_list="kile kbibtex gimp inkscape" 
	    
	    if [ $basics == 'y' ]; then		    
		command $install_command $basics_list
	    fi
	    if [ $embedded == 'y' ]; then
		command $install_command $embedded_list
	    fi 
	    if [ $software == 'y' ]; then
		command $install_command $software_list
	    fi 
	    if [ $web == 'y' ]; then
		command $install_command $web_list
	    fi
	    if [ $publish_design == 'y' ]; then
		command $install_command $publish_design_list
	    fi	    
	    ;;
	h)
	    echo -e $usage
	    exit
	    ;;
	*)
	    echo -e $usage
	    exit
	    ;;
    esac
done

