#!/usr/bin/env python3

import sys
import os
os.environ['USE_PYGEOS'] = '0'
import geopandas as gp
from pyogrio import read_dataframe, write_dataframe, list_layers, read_info

CRS = "EPSG:32630"

args = sys.argv[:]
args.pop(0)

FILEPATH, OUTPATH, LAYER = args
print(f'Update {FILEPATH} {OUTPATH} {LAYER}')
GF = read_dataframe(FILEPATH).set_crs(CRS, allow_override=True)
write_dataframe(GF, OUTPATH, layer=LAYER)
