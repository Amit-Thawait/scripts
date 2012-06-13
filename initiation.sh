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
	    
	    distribution=`cat /etc/*release`
	    if [[ $distribution =~ $fedora ]] || [[ $distribution =~ $redhat ]] || [[ $distribution =~ $centos ]]; then
	        if [ $basics == 'y' ]; then
		    rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
		    yum install -y emacs vlc mozilla-vlc wine tmux emacs-*

		fi
		if [ $embedded == 'y' ]; then
		    yum install -y geda icarus vhdl iverilog gwave makehuman gerbv kicad alliance
		fi 
		if [ $software == 'y' ]; then
		    yum install -y fpc gcc-arm gcl clisp cmucl grass octave
		fi 
		if [ $web == 'y' ]; then
		    yum install -y Django* wordpress drupal ruby* rails
		fi
		if [ $publish_design == 'y' ]; then
		    yum install -y kile kbibtex 
		fi
	    elif [[ $distribution =~ $ubuntu ]] || [[ $distribution =~ $debian ]]; then
		if [ $basics == 'y' ]; then
		    apt-get update --assume-yes 
		    apt-get install --assume-yes --force-yes aptitude vlc vlc-plugin-pulse mozilla-plugin-vlc emacs emacs-goodies-el git-core build-essential
		fi
		if [ $embedded == 'y' ]; then
		    aptitude install -y geda icarus vhdl verilog
		fi
		if [ $software == 'y' ]; then
		    aptitude install -y fpc gcc-arm
		fi
		if [ $web == 'y' ]; then
		    aptitude install -y Django wordpress drupal ruby
		fi
		if [ $publish_design == 'y' ]; then
		    aptitude install -y kile kbibtex
		fi
	    else
		echo -e "UNKNOWN DISTRIBUTION\n Exiting NOW!"    
	    fi
	    
	    # checking if git is installed on the system
	    which git &>/dev/null
	    if [ $? -eq 0 ]; then
		# setting git global settings
		local_git_config_file=/home/$local_user/.gitconfig
		sudo -u $local_user git config --file $local_git_config_file color.ui true
		sudo -u $local_user git config --file $local_git_config_file user.name "Koustubh Sinkar"
		sudo -u $local_user git config --file $local_git_config_file user.email ksinkar@gmail.com
		# setting other customizations
		cd /home/$local_user
		git clone git://github.com/ksinkar/ksinkar.git
		mv ksinkar dot_files
		chown --recursive $local_user:$local_user dot_files
		cd dot_files
		cp --force --recursive --preserve .* /home/$local_user/
		cd ..
		sudo -u $local_user rm -rf dot_files
	    else
		echo "git command not found."
	    fi

	    #checking if emacs is installed on the system
	    which emacs &>/dev/null
	    if [ $? -eq 0 ]; then
	        #setting emacs customizations
		emacs_load_path='/home/'$local_user'/.emacs.d'
		mkdir $emacs_load_path
		wget http://cx4a.org/pub/auto-complete/auto-complete-1.3.1.tar.bz2
		tar -xvjf auto-complete-1.3.1.tar.bz2
		cd auto-complete-1.3.1
		make install DIR=$emacs_load_path
		cd ..
		rm -rf auto-complete-1.3.1 auto-complete-1.3.1.tar.bz2		    
		cd $emacs_load_path
		wget https://raw.github.com/capitaomorte/autopair/master/autopair.el
		cd ..
		chown --recursive $local_user:$local_user '.emacs.d'
	    else
		echo "emacs not properly installed on this system"
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

