#!/bin/bash

# Choose encoding You want to decode to UTF-8 (FROM encoding)
source_encoding='iso-8859-1'

# Recursively find all files in directories and subdirectories
for file in $(find . -type f -print0 | xargs -0)
do
	# Check the file encoding and print only the charset
	encoding=$(file -i $file | awk '{print $3}')
	# echo "$encoding"
	if [[ $encoding == "charset=${source_encoding}" ]]; then
		( iconv -f $source_encoding -t utf-8 $file -o $file | xargs -0 )
	fi
done
