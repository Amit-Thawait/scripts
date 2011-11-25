#!/bin/bash

#read -p "Please enter the database name: " db_name
read -p "Please enter the username: " username
read  -s -p "Please enter the password: " password

mysql -u$username  -p$password < get_database_list.sql > db_list.txt 
FILE=db_list.txt
echo 'DATABASES' > output.txt

BAKIFS=$IFS
IFS=$(echo -en "\n\b")
exec 3<&0
exec 0<"$FILE"
while read -r db_name
  do
    if [[ "$db_name" == mostfit_box ]]; then
      a=8
    elif [[ "$db_name" =~ mostfit_ ]]; then
      echo "___________________________________________________" >> output.txt
      echo $db_name >> output.txt  
      mysql -u$username -p$password -D$db_name < query.sql >> output.txt
      echo "___________________________________________________" >> output.txt
    fi  
  done
exec 0<&3
     
# restore $IFS which was used to determine what the field separators are
IFS=$BAKIFS
