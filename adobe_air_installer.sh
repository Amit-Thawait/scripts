#!/bin/bash

    # Copyright(C) 2013 Koustubh Sinkar 
    # Special thanks to Amit Thawait 

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

usage="\nUSAGE:\t\t ./adobe_air_installer.sh [options]\nDESCRIPTION:\t This script is for installing the Adobe Air for Ubuntu\n\nOPTIONS:\n\t -x \t does the installation for Adobe Air installation\n\t -h \t\t displays this help"

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
	    machine_hardware=`uname -p`

	    installation_dir=adobe_air_installation dependencies
	    adobe_air_runtime_link=http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
	    mkdir -p $installation_dir
	    cd $installation_dir
	    wget -c $adobe_air_runtime_link

	    if [[ $distribution =~ $fedora ]] || [[ $distribution =~ $redhat ]] || [[ $distribution =~ $centos ]]; then
		echo -e "Installing dependencies for Redhat/Fedora"
		yum install ld-linux.so.2
		yum install gtk2-devel.i686
		yum install libdbus-glib-1.so.2
		yum install libhal.so.1
		yum install rpm-devel.i586
		yum install libXt.so.6
		yum install gnome-keyring-devel.i686
		yum install libDCOP.so.4
		yum install libxml2-devel.i686
		yum install nss-devel.i686
		echo -e 'Finished installing dependencies for Redhat/Fedora'
	    elif [[ $distribution =~ $ubuntu ]] || [[ $distribution =~ $debian ]]; then
		echo -e "Installing dependencies for Debian/Ubuntu"
		support_lib_link=http://jeffhendricks.net/getlibs-all.deb

		wget -c $support_lib_link

		apt-get install gdebi-core
		gdebi getlibs-all.deb
		apt-get install libhal-storage1 libgnome-keyring0 lib32nss-mdns

		getlibs -l libhal-storage.so.1
		getlibs -l libgnome-keyring.so.0.2.0
		ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0
		echo -e 'Finished installing dependencies for Debian/Ubuntu'
	    else
		echo -e "UNKNOWN DISTRIBUTION\n Exiting NOW!"
		exit
	    fi

	    echo "Beginning installing of Adobe AIR"
	    chmod +x AdobeAIRInstaller.bin
	    command ./AdobeAIRInstaller.bin
	    echo "Adobe AIR installation complete"
	    echo "Now open your *.air application with Adobe AIR"
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