#!/usr/bin/env python3

import sys
import os
os.environ['USE_PYGEOS'] = '0'
import geopandas as gp
from pyogrio.errors import DataSourceError
from pyogrio import read_dataframe, write_dataframe, list_layers, read_info

CRS = "EPSG:32630"

args = sys.argv[:]
args.pop(0)

FILEPATH, OUTPATH, LAYER = args
FILEPATH, OUTPATH, LAYER = '/home/diablo/tmp/geography-simple.geojson', 'x.gpkg', 'outer'

print(f'Update {FILEPATH} {OUTPATH} {LAYER}')
try:
    GF = read_dataframe(FILEPATH).set_crs(CRS, allow_override=True)    
    write_dataframe(GF, OUTPATH, layer=LAYER)
except DataSourceError:
    print(f'Failed {FILEPATH} {OUTPATH} {LAYER}')
