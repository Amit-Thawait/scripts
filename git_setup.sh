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

# checking if git is installed on the system
which git &>/dev/null
if [ $? -eq 0 ]; then
    # setting git global settings
    local_git_config_file=$HOME/.gitconfig
    git config --file $local_git_config_file color.ui true
    git config --file $local_git_config_file user.name "Koustubh Sinkar"
    git config --file $local_git_config_file user.email ksinkar@gmail.com
    # setting other customizations
    source_workspace=$HOME/source
    mkdir -p $source_workspace
    cd $source_workspace
    git clone --recursive git://github.com/ksinkar/ksinkar.git
    mv ksinkar dot_files
    cp --force --recursive --preserve dot_files/.* $HOME/
else
    echo "git not installed"
fi

