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
if [ -e *info.yml ];
then 
    FILE="translations/$LANGCODE.po"
    cd $DIR 
    if [ -f $FILE ]; 
    then
      find . -not \( -path ./translations -prune \) -type f -name "*.*" | xargs xgettext -o $FILE --from-code utf-8 --omit-header --directory $DIR --keyword=t -j &&
      echo `date`" - Updated existing language file moduleroot/translations/$LANGCODE.po"
    else
      find . -not \( -path ./translations -prune \) -type f -name "*.*" | xargs xgettext -o $FILE --from-code utf-8 --directory $DIR --keyword=t &&
      echo `date`" - New language file created: $FILE"
    fi
else
    echo `date`" - Call the script inside the module root folder. Exiting now."
fi