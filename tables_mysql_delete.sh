#!/bin/sh

while getopts ":vu:p:D:" opts; do
  case $opt in
    u)
      username=$OPTARG
      ;;
    p)
      password=$OPTARG
      ;;
    D)
      db_name=$OPTARG
      ;;    
    v)
      read -p "Please enter the database name: " db_name
      read -p "Please enter the username: " username
      read -p "Please enter the password: " password
      ;;
  esac    
done
#mysqldump -u$username -p$password --add-drop-table --no-data $db_name | grep ^DROP | mysql -u$username -p$password -D $db_name
