reset
unset xtics
unset ytics
unset border
unset key
#unset legend
unset title
set lmargin at screen 0
set tmargin at screen 0
set rmargin at screen 1
set bmargin at screen 1

set palette rgbformulae 34,35,36

zoom = "8"

zoom2 = (zoom)+8
print(zoom2)

width = 2**(zoom2)

# set xrange [2*width/4:3*width/4-1]
# set yrange [2*width/4:3*width/4]
set xrange [0:width-1]
set yrange [0:width]

set object rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#000000" behind

# set terminal wxt size 512,512
# set terminal png size width/4,width/4
set terminal png size width,width

set output ("../output/planet-".zoom.".png")

plot ('../output/planet-7.txt') using ($1):(width-1-$2):(log($3)) with dots palette