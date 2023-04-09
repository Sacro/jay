#!/usr/bin/env bash

FILEPATH=$1

if [ ! -d venv ]; then
    echo Set up python3 virtual environment
    python3 -m venv venv
    source venv/bin/activate
    pip3 install --upgrade pip
    pip3 install -r requirements.txt
else
    source venv/bin/activate
fi

if [ ! -d ./node ]; then
    . ./node.sh
fi

for i in output
do
    if [ ! -d ${i} ]; then
        mkdir -p ${i}
    fi
done

for layer in $(./simplifypoints.py ${FILEPATH})
do
    ./maplayer.sh ${FILEPATH} ${layer}
done
