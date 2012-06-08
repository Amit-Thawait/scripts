#!/bin/bash

usage="usage: ./initation.sh [-x] [-h]\nThis script is for creating the default development setup preferred by Koustubh Sinkar on any *nix computer that he setups"

while getopts "xh" opt; do
    case $opt in
	x)	    
	    user=`whoami`
	    if [ $user != "root" ]; then
		echo -e 'You are not su. Please login as root and rerun the script.\n'
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
	    if [[ $distribution =~ $fedora ]] || [[ $distribution =~ $redhat ]] || [[ $distribution =~ $centos ]]; then
		echo -e 'Which packages would you like to setup?\n'
		read -p '1. Basic Necessities [y/N]' basics
		read -p '2. Embedded Systems Development [y/N]' embedded
		read -p '3. Software Development [y/N]' software
		read -p '4. Web Development [y/N]' web
		read -p '5. Publishing and Designing' publish_design
		if [ $basics == 'y']; then
		    rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
		    yum install -y emacs vlc mozilla-vlc wine
		elif [ $embedded == 'y' ]; then
		    yum install -y geda icarus vhdl iverilog gwave makehuman gerbv kicad alliance 
		elif [ $software == 'y' ]; then
		    yum install -y fpc gcc-arm gcl clisp cmucl grass octave 
		elif [ $web == 'y' ]; then
		    yum install -y Django* wordpress drupal ruby* rails
		elif [ $publish_design == 'y' ]; then
		    yum install -y kile kbibtex 
		else
		    exit 
		fi
	    elif [[ $distribution =~ $ubuntu ]] || [[ $distribution =~ $debian ]]; then
		echo -e 'Which packages would you like to setup?'
		read -p '1. Basic Necessities [y/N]' basics
		read -p '2. Embedded Systems Development [y/N]' embedded
		read -p '3. Software Development [y/N]' software
		read -p '4. Web Development [y/N]' web
		read -p '5. Publishing and Designing' publish_design
		if [ $basics == 'y']; then
		    apt-get update --assume-yes 
		    apt-get install --assume-yes --force-yes aptitude vlc vlc-plugin-pulse mozilla-plugin-vlc emacs emacs-goodies-el git-core build-essential
		elif [ $embedded == 'y' ]; then
		    aptitude install -y geda icarus vhdl verilog
		elif [ $software == 'y' ]; then
		    aptitude install -y fpc gcc-arm
		elif [ $web == 'y' ]; then
		    aptitude install -y Django wordpress drupal ruby*
		elif [ $publish_design == 'y' ]; then
		    aptitude install -y kile kbibtex
		else
		    exit 
		fi
	    else
		echo -e "UNKNOWN DISTRIBUTION\n Exiting NOW!"    
	    fi
	    # checking if git is installed on the system
	    which git &>/dev/null
	    if [ $? -eq 0 ]; then
		echo "git command not found."
	    else
		cd /home/ksinkar
		git clone git@github.com/ksinkar/
		mv ksinkar/.* ./ --force
		rmdir ksinkar
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

