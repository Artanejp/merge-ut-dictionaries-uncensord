#!/bin/sh

# Author: UTUMI Hirosi (utuhiro78 at yahoo dot co dot jp)
# License: Apache License, Version 2.0

# Modified by: Kyuma Ohta (whatisthis dot sowhat at gmail dot com)

use_python="python3"
#censor_unsuitable_words="true"
alt_cannadic="true"
edict2="true"
#jawiki="true"
neologd="true"
personal_names="true"
place_names="true"
skk_jisyo="true"
sudachidict="true"

generate_latest="true"

ARG_UNCENSORED=""
ARG_PYTHON=""
__PYTHON=python

if [ "__xxx__$censor_unsuitable_words" != "__xxx__true" ] ; then
     ARG_UNCENSORED="--uncensored"
fi
if [ "__xxx__$use_python" != "__xxx__" ] ; then
    __PYTHON="$use_python"
    ARG_PYTHON="--use-python $__PYTHON"
fi


rm -rf mozcdic-ut*

if [ "$alt_cannadic" = "true" ] && [ "$generate_latest" != "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-alt-cannadic.git
fi

if [ "$alt_cannadic" = "true" ] && [ "$generate_latest" = "true" ]; then
    cd ../alt-cannadic/
    sh make.sh $ARG_PYTHON
    cd ../merge/
fi

if [ "$edict2" = "true" ] && [ "$generate_latest" != "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-edict2.git
fi

if [ "$edict2" = "true" ] && [ "$generate_latest" = "true" ]; then
    cd ../edict2/
    sh make.sh $ARG_PYTHON
    cd ../merge/
fi

if [ "$jawiki" = "true" ] && [ "$generate_latest" != "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-jawiki.git
fi

if [ "$jawiki" = "true" ] && [ "$generate_latest" = "true" ]; then
    cd ../jawiki/
    sh make.sh $ARG_UNCENSORED $ARG_PYTHON
    cd ../merge/
fi

if [ "$neologd" = "true" ] && [ "$generate_latest" != "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-neologd.git
fi

if [ "$neologd" = "true" ] && [ "$generate_latest" = "true" ]; then
    cd ../neologd/
    sh make.sh $ARG_UNCENSORED $ARG_PYTHON
    cd ../merge/
fi

if [ "$personal_names" = "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-personal-names.git
fi

if [ "$personal_names" = "true" ] && [ "$generate_latest" = "true" ]; then
    bzip2 -dfk mozcdic-ut-personal-names/mozcdic-ut-personal-names.txt.bz2
    mv mozcdic-ut-personal-names/mozcdic-ut-personal-names.txt .
fi

if [ "$place_names" = "true" ] && [ "$generate_latest" != "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-place-names.git
fi

if [ "$place_names" = "true" ] && [ "$generate_latest" = "true" ]; then
    cd ../place-names/
    sh make.sh $ARG_PYTHON
    cd ../merge/
fi

if [ "$skk_jisyo" = "true" ] && [ "$generate_latest" != "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-skk-jisyo.git
fi

if [ "$skk_jisyo" = "true" ] && [ "$generate_latest" = "true" ]; then
    cd ../skk-jisyo/
    sh make.sh $ARG_PYTHON
    cd ../merge/
fi

if [ "$sudachidict" = "true" ] && [ "$generate_latest" != "true" ]; then
    git clone --depth 1 https://github.com/utuhiro78/mozcdic-ut-sudachidict.git
fi

if [ "$sudachidict" = "true" ] && [ "$generate_latest" = "true" ]; then
    cd ../sudachidict/
    sh make.sh $ARG_UNCENSORED $ARG_PYTHON
    cd ../merge/
fi

if [ "$generate_latest" != "true" ]; then
    bzip2 -dfk mozcdic-ut-*/mozcdic-ut-*.txt.bz2
    mv mozcdic-ut-*/mozcdic-ut-*.txt .
fi

cat mozcdic-ut-*.txt > mozcdic-ut.txt

# IDを更新、重複エントリを削除、コストを調整
$__PYTHON merge_dictionaries.py mozcdic-ut.txt
