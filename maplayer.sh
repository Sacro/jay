#!/usr/bin/env bash

FILEPATH=$1
FILESTUB=$(basename ${FILEPATH} | sed 's/\..*$//')
LAYER=$2

echo ${FILESTUB} ${LAYER}

NODE_PATH=./$(ls -d nvm/versions/node/*/bin | tail -1)
export PATH=${PATH}:${NODE_PATH}:${PWD}/node/node_modules/mapshaper/bin/

for FILE in ${FILESTUB}.geojson ${FILESTUB}-simple.geojson
do
    if [ ! -s ${TEMP}/${FILE} ]; then
        rm ${TEMP}/${FILE}
    fi
done

./dumpgeojson.py ${FILEPATH} ${TEMP}/${FILESTUB}.geojson ${LAYER}

mapshaper-xl 16gb ${TEMP}/${FILESTUB}.geojson precision=0.1 -snap endpoints interval=0.1 -simplify interval=1.0 keep-shapes -o format=geojson geojson-type=FeatureCollection ${TEMP}/${FILESTUB}-simple.geojson

./dumplines.py ${TEMP}/${FILESTUB}-simple.geojson output/${FILESTUB}-simple.gpkg ${LAYER}
