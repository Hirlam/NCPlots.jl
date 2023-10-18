# Metcoop 

Example reading from MEPS archive at MET Norway  

```julia
using Glob, NCDatasets, NCPlots, GLMakie

archive="/lustre/storeB/immutable/archive/projects/metproduction/MEPS/2023/01/30"

files = glob("meps_det_2_5km*.nc", archive)   # use e.g.  "....*00.nc" to only match files with 00:00 UTC

ds = NCDatasets.Dataset(files, aggdim="cycle", isnewdim=true, constvars=["x","y","hybrid","time"],deferopen=false) 

fig = Figure() 
fcint = 3; llmax=66; nlev=65


tsl, lsl,csl = SliderGrid(fig[2,1], 
  (label="LL",range=1:(llmax-fcint),startvalue=1), 
  (label="Level",range=nlev:-1:1,startvalue=nlev),
   (label="Cycle",range=2:length(files),startvalue=2),
   tellheight=false,
   width=350
)
ax= Axis(fig[1,2])

varname = "air_temperature_ml"
var = ds[varname]

dsv = @lift(var[:,:,$(lsl.value),$(tsl.value),$(csl.value)] -
            var[:,:,$(lsl.value),$(tsl.value)+3,$(csl.value)-1]
            )

title = @lift(string(Analysis increment, " " ,varname,  basename(files[$(cycle_sl.value)]))
subtitle = @lift(string(" Level ", $(lsl.value), "forecast", $(tsl.value)-1, " Hour") )

heatmap!(ax,dsv,colormap=:RdBu,colorrange=(-2,2))
Label(fig[0,:],label,tellwidth=false)
Label(fig[1,:],label,tellwidth=false)
```

![](../assets/metcoop_menu.png)