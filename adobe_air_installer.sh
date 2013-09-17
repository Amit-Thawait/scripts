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
	    if [[ $distribution =~ $fedora ]] || [[ $distribution =~ $redhat ]] || [[ $distribution =~ $centos ]]; then
		echo -e "Installation not yet supported on the Redhat distributions. Coming Soon."
	    elif [[ $distribution =~ $ubuntu ]] || [[ $distribution =~ $debian ]]; then

		installation_dir=adobe_air_installation dependencies
		adobe_air_runtime_link=http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
		support_lib_link=http://jeffhendricks.net/getlibs-all.deb

		mkdir -p $installation_dir
		cd $installation_dir
		
		wget -c $adobe_air_runtime_link
		wget -c $support_lib_link

		apt-get install gdebi-core
		gdebi getlibs-all.deb
		apt-get install libhal-storage1 libgnome-keyring0 lib32nss-mdns

		getlibs -l libhal-storage.so.1
		getlibs -l libgnome-keyring.so.0.2.0
		ln -s /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0

		chmod +x AdobeAIRInstaller.bin
		command ./AdobeAIRInstaller.bin

		echo "Now open your *.air application with Adobe AIR"
	    else
		echo -e "UNKNOWN DISTRIBUTION\n Exiting NOW!"
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