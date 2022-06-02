#!/bin/bash 

# with help command you can have all supprted values properties shown
# pass xml name , xml property and value 



# Check that exactly 3 values were passed in
if [ $# -ne 3 ]; then
echo 1>&2 “This script replaces xml element’s value with the one provided as a command parameter \n\n\tUsage: $0 <xml filename> <property name> <propertyvalue>”
exit 127
fi

#just search for property by full name and add is=f it doesnt exist or replace if exists
xml_config=$1
name=$2
value=$3
#dont use when array expected!!!
path=$(find -name "*$xml_config*")

function addProperty() {

  local entry="<property><name>$name</name><value>${value}</value></property>"
  local escapedEntry=$(echo $entry | sed 's/\//\\\//g')
  sed -i "/<\/configuration>/ s/.*/${escapedEntry}\n&/" $path
}




