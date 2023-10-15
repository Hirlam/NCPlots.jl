
using NCPlots

ds = Dataset("/home/roel/era5/era5_pressure_levels_geopotential_pv.nc")

t = Observable(1)
dsv1 = @lift(nomissing(view(ds,time=$t)["pv"][:,:]))
lons  = collect(ds["longitude"])
lats  = collect(ds["latitude"])
geop1 = @lift(nomissing(collect(view(ds,time=$t)["z"])))

x,y,z = lonlat2xyz(lons,lats) 

function plot_int!(ax,t::Observable)



xn = @lift(x.*$geop1)
yn = @lift(y.*$geop1)
zn = @lift(z.*$geop1)


crange=(-2e-6,2e-6)

fig = Figure(resolution=(1200,1200), figure_padding=0)
ax = LScene(fig[1,1],show_axis=false)

plt1= surface!(ax,xn,yn,zn,color=dsv1,colorrange=crange,invert_normals=true,colormap=:PiYG)
#plt2= surface!(ax,x.+d,y,z,color=field,colorrange=crange,invert_normals=true,colormap=Reverse(:RdBu))
#plt3 = surface!(ax,x.+d*cosd(60),y .+d*sind(60),z,color=field,invert_normals=true,colorrange=crange,colormap=Reverse(:PiYG))

#e=4
#f = surface!(ax,[-e ,-e, e, e], [-e, e, e, -e],[-1,-1,-1,-1],color=:black)

fig