#!/bin/bash

DATADIR=$1

ADDONS=$2

if [ -z "${DATADIR}" ]; then
	read -p "Enter relative path to repo data directory: "  DATADIR
fi

if [ -z "${ADDONS}" ]; then
	read -p "Enter relative path to addons directory: "  ADDONS
fi

if [[ $DATADIR != *"/" ]]; then
  DATADIR=$DATADIR/
fi

if [[ $ADDONS != *"/" ]]; then
  ADDONS=$ADDONS/
fi

echo
echo "Repository Data directory: $DATADIR"
echo
echo "Addons Source directory: $ADDONS"
echo

ADDONS=$( ls -d  $ADDONS*/ )
echo "List of addons to be included:"
echo "$ADDONS"
echo

read -N 1 -s -p "Continue? [Y]es, any other to quit... " REPLY
echo

if [ $REPLY != "Y" ] && [ $REPLY != "y" ]
then
	exit
fi

echo
echo "Running script"

./create_repository.py --datadir=$DATADIR ${ADDONS//"\n"/" "}

echo

read -N 1 -s -p "Press any key to quit... " REPLY

exit
