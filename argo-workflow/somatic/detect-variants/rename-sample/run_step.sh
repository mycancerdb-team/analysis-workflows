#!/bin/bash

set -eou pipefail
basen=`basename "$3"`
basen="renamed.$basen"

#escape spaces, otherwise bcftools will try to use them as a delimiter
#triple backslash to escape within backticks and then again within sed
old_name=`echo "$1" | sed 's/ /\\\ /g'`
new_name=`echo "$2" | sed 's/ /\\\ /g'`

echo "$old_name $new_name" > sample_update.txt
/opt/bcftools/bin/bcftools reheader -s sample_update.txt -o "$basen" "$3"
