# Sliders Menus



```julia

crangedict = Dict(
    "pv" => (-2e-6,2e-6),
    "z" => (20000.0,50000.0)
)

fig = Figure()

menu = Menu(fig[1,1],options=setdiff(keys(ds),dimnames(ds)))
menu2 = Menu(fig[1,2], options=colorschemes)
sl = SliderGrid(fig[2,1],
    (label="time", range=1:length(ds["time"]),startvalue=1,format = x-> Dates.format(ds["time"][x],"yyyymmdd-HH"))
    )
ax = LScene(fig[3,1], show_axis=false)
colorrange=@lift(crangedict($(menu.selection)))
colormap=@lift(colorschem)

ds = Dataset("...")
dsv = @lift(view(ds,time=$(sl.sliders[1].value))[$(menu.selection)])
plotvar!(ax,dsv,colorrange=colorrange,colormap=:RdBu)

```


## Level slider



