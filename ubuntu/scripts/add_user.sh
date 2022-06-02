#!/bin/bash

group=""
user=""
password=""
default_password=123

OPTIND=1
while getopts "h?p:g:u:" opt; do
    case "$opt" in
        h)
            echo "Option h is given"
            ;;
        p)
            parg="$OPTARG"
	    password=$parg
            ;;
        u)
            uarg="$OPTARG"
	    user=$uarg
            ;;
        g)
            garg="$OPTARG"
	    group=$garg
            ;;
        *)
            echo -e  "Usage: $0 [-h] [-p value] [-g value] [-u value]\n
	-g variable - user group;\n
    	-u variable - username;\n
    	-p variable - password.\n
    	If no password specified default '123' password will be assigned\n
    	----WARNING---- user can't be created without username specified!" >&2
            exit 1
        ;;
    esac
done

shift "$(($OPTIND -1))"

add_user() {
 if [[ -z "${password}" ]]
	then
	password=$default_password

 fi

 if [[ -z "${group}" ]]
    then
        adduser ${user} --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
    else 
      if grep -q $group /etc/group
          then
            echo "group $group exists"
          else
             echo "group $group  does not exist, creating --- "
             addgroup $group 
      fi
      adduser --ingroup ${group}  ${user} --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password   
 fi
echo "${user}:${password}" | chpasswd
echo "User ${user} with password ${password} was created " 
}

add_user





