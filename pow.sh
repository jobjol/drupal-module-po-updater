#!/bin/bash
DIR="$(pwd)"
LANGCODE=$1

# Check for mandantory argument.
if [ -z $LANGCODE ];
then
    echo `date`" - Missing mandatory arguments: Language code. "
    echo `date`" - Usage: ./pow.sh [LANGCODE] . "
    exit 1
fi

# If translations directory does not exist, create it.
if [ ! -d "translations" ]; 
then
    mkdir $DIR/translations
fi

# Check if a .module file exists in pwd
if [ -e *.module ]; 
then 
    FILE="translations/$LANGCODE.po"
    cd $DIR 
    if [ -f $FILE ]; 
    then
	find  $DIR -name "*.*" | xargs xgettext -o $FILE --keyword=t --language=PHP --force-po -j &&
	echo `date`" - Updated existing language file moduleroot/translations/$LANGCODE.po"  
    else
	find $DIR -name "*.*" | xargs xgettext -o $FILE --keyword=t --language=PHP --force-po  &&
	echo `date`" - New language file created: $FILE"
    fi
else
    echo `date`" - Call the script inside the module root folder. Exiting now."
fi