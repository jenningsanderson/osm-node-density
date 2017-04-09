var merc = new (require("sphericalmercator"))({size: 256});
var osmium = require('osmium');
var handler = new osmium.Handler();
var fs      = require('fs');
var liner = require('./code/liner')()

var count = 0;
var tiles = {};

handler.on('init', function(){
    console.log("Starting... ")
})

handler.on('node', function(node) {
    count++;
    if (count % 100000 === 0) console._stderr.write("\rprocessed "+count+" nodes.");
    var xy = merc.px([node.lon, node.lat], 15), //This is not the zoom level, this is zoom + (8)
        x = Math.floor(xy[0]/256),
        y = Math.floor(xy[1]/256);
    if (!tiles[x])
        tiles[x] = {};
    if (!tiles[x][y])
        tiles[x][y] = 0;
    tiles[x][y]++;
});

handler.on('after_nodes',function() {
    console.error("\nDone processing "+count+" nodes.");
    for (var x in tiles)
        for (var y in tiles[x]) {
            var lat = merc.ll([0,y*256], 15)[1];
            outFile.write(x + " " + y +" " + Math.round(tiles[x][y] / Math.cos(lat*Math.PI/180))+"\n");
        }
});

if (!process.argv[2] || !process.argv[3]){
    console.log("Need both input and output file")
    process.exit(1)
}

console.log("Input: ", process.argv[2])
console.log("Output: ", process.argv[3])

var inFile = new osmium.File(process.argv[2], "pbf");
var outFile = new fs.createWriteStream(process.argv[3])

var reader = new osmium.Reader(inFile,{ node: true, way: false });
osmium.apply(reader, handler)
