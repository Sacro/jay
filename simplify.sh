#!/usr/bin/env bash

FILEPATH=$1

for i in output archive
do
    if [ ! -d ${i} ]; then
        mkdir -p ${i}
    fi
done

FILESTUB=$(basename ${FILEPATH} | sed 's/\..*$//')
if [ -s output/${FILESTUB}-simple.gpkg ]; then
    mv output/${FILESTUB}-simple.gpkg archive
fi

for layer in $(./simplifypoints.py ${FILEPATH})
do
    ./maplayer.sh ${FILEPATH} ${layer}
done
