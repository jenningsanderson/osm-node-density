Visualizing OSM Node Density
============================

Using [Martin Raifer's osm-node-density visualization](http://www.openstreetmap.org/user/tyr_asd/diary/22363), I re-produced the map with a workflow designed to be compatible with mapbox-gl.

# Running this Fork:

### Stage 1: pbf --> txt

    node --max_old_space_size=64000 stage1.js /data/osm/latest-planet.osm.pbf ./output/planet-7.txt    
    
### Stage 2: gnuplot
    
Set the proper outputs and inputs in `code/plot.gp` like `../output/planet-7` and then run with:
    
    gnuplot code/plot.gp

### Stage 3: Can use the `Built Tiles` notebook to build the local tiles, or run the following script to geo-reference the result:

    export GDAL_TIFF_OVR_BLOCKSIZE=256
    gdal_translate -of Gtiff \
      -co BLOCKXSIZE=256 -co BLOCKYSIZE=256 -co COMPRESS=LZW \
      -a_ullr -20026376 20048966 20026376 -20048966 \
      -a_srs EPSG:3857 planet.png planet.geotiff

Upload the planet.geotiff to mapbox to make raster mbtiles and then load into a mapbox-gl style like so:

    map.addLayer({
        'id': 'planet-node-density',
        'type':'raster',
        'source': {
            'type': 'raster',
            'url' : "mapbox://< tileset id >",
            "tileSize": 256
        }
     });


Original Licensing
------------------

Code base from Martin Raifer

Based on [© OpenStreetMap data (ODbL)](http://www.openstreetmap.org/copyright).

Visualizations [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/).

