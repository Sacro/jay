# jay

These helper scripts that download dependencies and run [mapshaper](https://github.com/mbloch/mapshaper) on mixed geometry [GeoPackage](https://www.ogc.org/standard/geopackage/) geography files

## Assumptions

The GeoPackage data is in a projected rather than longitude and latitude coordinate system

## Implementation

Running the `simplify.sh` script on the GeoPackage file `input.gpkg` to create a simplified `input-simplified.gpkg` in the `output` directory:

    $ ./simplify.sh input.gpkg

The script installs a local `python3` and `nodejs` environment and processes and creates simplified GeoPackage layer

### `dumpgeojson.py`

Writes GeoPackage layer data as GeoJSON to the `tmp` directory

### `dumplines.py`

Writes simplified GeoJSON layer in the `tmp` directory to the GeoPackage data layer

### `maplayer.sh`

Wrapper script that simplifies a geometry layer in the GeoPackage file by creating a GeoJSON layer file, simplifying the layer using `mapshaper-xl` and writes the simplified layer to the output GeoPackage file layer

The current `mapshaper` script snaps endpoints, and rounds coordinates to one decimal place

### `node.sh`

Installs a local `nvm` and `nodejs` environment and installs `mapshaper` in the `node` directory

### `simplifypoints.py` 

Extracts geometry layers, rounds coordinates to one decimal place for Point geometry layer or prints out the layer name

### `simplify.sh`

The wrapper script that orchestrates the sequencing other scripts
