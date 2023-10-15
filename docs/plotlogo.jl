
using NCPlots, NCDatasets, GLMakie

ds = Dataset("/home/roel/era5/era5_pressure_levels_geopotential_pv.nc")

#t = Observable(1)

t1 = 1; t2=1+24; t3=1+48
dsv1 = nomissing(view(ds,time=t1)["pv"][:,:])
dsv2 = nomissing(view(ds,time=t2)["pv"][:,:])
dsv3 = nomissing(view(ds,time=t3)["pv"][:,:])

lons  = collect(ds["longitude"])
lats  = collect(ds["latitude"])

z1 = nomissing(collect(view(ds,time=t1)["z"]))
z2 = nomissing(collect(view(ds,time=t2)["z"]))
z3 = nomissing(collect(view(ds,time=t3)["z"]))


dsv1v = NCPlots.lonpadview(dsv1)
dsv2v = NCPlots.lonpadview(dsv2)
dsv3v = NCPlots.lonpadview(dsv3)

z1v = NCPlots.lonpadview(z1)
z2v = NCPlots.lonpadview(z2)
z3v = NCPlots.lonpadview(z3)

lonsv = NCPlots.lonpadview(lons)

x,y,z = lonlat2xyz(lonsv,lats)

crange=(-2e-6,2e-6)



d = 150000
fig = Figure(resolution=(1200,1200), figure_padding=0)
# backgroundcolor=(:white,0))
ax = LScene(fig[1,1],show_axis=false)

plt1= surface!(ax,z1v.*x,z1v.*y,z1v.*z,color=dsv1v,colorrange=crange,invert_normals=true,colormap=:PiYG)
plt2= surface!(ax,z2v.*x.+d,z2v.*y,z2v.*z,color=dsv2v,colorrange=crange,invert_normals=true,colormap=Reverse(:RdBu))
plt3 = surface!(ax,z2v.*x.+d*cosd(60),z2v.*y .+d*sind(60),z2v.*z,color=dsv3v,invert_normals=true,colorrange=crange,colormap=Reverse(:PiYG))

#e=4
#f = surface!(ax,[-e ,-e, e, e], [-e, e, e, -e],[-1,-1,-1,-1],color=:black)

fig
