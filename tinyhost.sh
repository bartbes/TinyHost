#!/bin/bash

########################################
#  Copyright (c) 2011 Bart van Strien  #
#                                      #
#  All rights reserved. (for now)      #
#                                      #
########################################

if [ $# -lt 1 ]; then
	echo "Usage: $0 [-m <mimetype>] <[-f] filename|-i>"
	exit 1
fi

while getopts "m:f:i" OPTION; do
	case $OPTION in
		m)
			MIME=$OPTARG
			;;
		f)
			FILE=$OPTARG
			;;
		i)
			TMPFILE=1
			;;
	esac
done
shift $((OPTIND-1))

if [[ $TMPFILE == 1 ]]; then
	FILE=`mktemp`
	cat > $FILE
fi

if [[ $FILE == "" ]]; then
	FILE=$1
fi

if [ ! -e $FILE ]; then
	echo "Input file \"$FILE\" does not exist."
	exit 2
fi

if [[ $MIME  == "" ]]; then
	MIME=`file -ib $FILE | awk '{print $1$2}'`
fi

ENCODED=$(base64 $FILE | \
	perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg')
DATAURI="data:$MIME;base64,$ENCODED"

echo $(curl -s "http://tinyurl.com/api-create.php?url=$DATAURI")

if [[ $TMPFILE -eq 1 ]]; then
	rm $FILE
fi

