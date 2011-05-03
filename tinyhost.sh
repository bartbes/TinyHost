#!/bin/bash

########################################
#  Copyright (c) 2011 Bart van Strien  #
#                                      #
#  All rights reserved. (for now)      #
#                                      #
########################################

if [ $# -lt 1 ]; then
	echo "Usage: $0 <filename>"
	exit 1
fi

if [ ! -e $1 ]; then
	echo "Input file $1 does not exist."
	exit 2
fi

MIME=`file -ib $1 | awk '{print $1$2}'`
ENCODED=$(base64 $1 | \
	perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg')
DATAURI="data:$MIME;base64,$ENCODED"

RESULT=$(curl -s "http://tinyurl.com/api-create.php?url=$DATAURI")
echo $RESULT

