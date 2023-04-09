#!/usr/bin/env python3

import sys
import os

os.environ["USE_PYGEOS"] = "0"
from pyogrio import read_dataframe, write_dataframe, list_layers
import geopandas as gp

OUTPATH = "output"
PRECISION = 1
args = sys.argv[:]
args.pop(0)

filelist = args
#filelist = ['../network-model.gpkg']

for filepath in filelist:
    layers = list_layers(filepath)
    for layer, g in layers:
        filestub = os.path.basename(filepath)
        if g != "Point":
            # print(f'{filestub}\t{layer}\t{g}')
            print(layer)
            continue
        gf = read_dataframe(filepath, layer=layer)
        gf = gf.dropna(axis=1)
        gs = gf["geometry"]
        gs = gp.points_from_xy(gs.x.round(PRECISION), gs.y.round(PRECISION))
        gf["geometry"] = gs
        outpath = filestub.rsplit(".", 1)
        outpath = f"{OUTPATH}/{''.join(outpath[:-1])}-simple.{outpath[-1]}"
        write_dataframe(gf, outpath, layer=layer, append=True)
