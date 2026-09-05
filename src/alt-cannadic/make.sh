#!/bin/sh

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

# Modified by: Kyuma Ohta (whatisthis dot sowhat at gmail dot com)

__PYTHON=python
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
    esac
    shift
done
      
$__PYTHON convert_alt_cannadic.py

bzip2 -k mozcdic-ut-*.txt
mv mozcdic-ut-*.txt* ../merge/
