#!/bin/sh

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

# Modified by: Kyuma Ohta (whatisthis dot sowhat at gmail dot com)

__PYTHON=python
UNCENSOR_UNSUITABLE="NO"
for x in "$@" ; do
    if [ "__xxx__$1" = "__xxx__" ] ; then
       break
    fi
    case "$1" in 
        --use-python )
	    shift
            if [ "__xxx__$1" != "__xxx__" ] ; then
                __PYTHON="$1"
                shift
            fi
	    continue
            ;;
        --uncensored )
            UNCENSOR_UNSUITABLE="YES"
	    shift
	    continue
            ;;
        --censored )
            UNCENSOR_UNSUITABLE="NO"
	    shift
	    continue
            ;;
    esac
    shift
done

$__PYTHON convert_jawiki.py
$__PYTHON ../common/adjust_entries.py mozcdic-ut-jawiki.txt
if [ "__xxx__$UNCENSOR_UNSUITABLE" != "__xxx__YES" ] ; then
    $__PYTHON ../common/filter_unsuitable_words.py mozcdic-ut-jawiki.txt
fi
bzip2 -k mozcdic-ut-*.txt
mv mozcdic-ut-*.txt* ../merge/
