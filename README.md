osm-node-density
================

A visualization of OpenStreetMaps node density ([read more](http://www.openstreetmap.org/user/tyr_asd/diary/22363)).

[![](http://wiki.openstreetmap.org/w/images/3/37/OSM-node-density-map-HD-crop-2014.png)](http://tyrasd.github.io/osm-node-density/)

Licensing
---------

Based on [© OpenStreetMap data (ODbL)](http://www.openstreetmap.org/copyright).

Visualizations [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/).




# Running this Fork:

### Stage 1: pbf --> txt

    node --max_old_space_size=64000 stage1.js /data/osm/us-west/denver-boulder.osh.pbf ./output/boulderdenver-9.txt
    
    
### Stage 2: Downscaling:
Set the root and the starting zoom level

    ./stage2.sh ~/osm-node-density/output/boulderdenver- 9
    
### Stage 3: gnuplot
    
Set the proper outputs and inputs in `code/plot.gp` like `../output/boulderdenver-` and then run with:
    
    gnuplot plot.gp

Manually do this for each zoom level, adjusting just the zoom = "z" each time to match the file

### Stage 4: Open the "Build Tiles" Notebook