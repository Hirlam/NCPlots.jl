module NCPlots


using Makie, CommonDataModel

export plot, plotvar!, addmeridian!, addequator!, lonlat2xyz


"""
    fig,ax,plt = plot(var)

Plots variable `var` on the sphere. Returns `fig` `ax` and `plt`. 
"""
function plot(var::Observable{<:CommonDataModel.AbstractVariable{T}}; kwargs...) where T

    fig = Figure(resolution=(1200,1200), figure_padding=0)
    ax = LScene(fig[1,1],show_axis=false)
    plt = plotvar!(ax,var; kwargs...)    

    #addequator!(ax,linewidth=2,color=:black) # ,linestyle=:dash)
    #addmeridian!(ax,linewidth=2,color=:black) #,linestyle=:dash)
#     display(fig)
    return fig,ax,plt     
end 

plot(var::CommonDataModel.AbstractVariable; kwargs...) = plot(Observable(var); kwargs...)

"""
    plotvar!(ax,var) 

Plots variables `var` into axis `ax`
"""
function plotvar!(ax,var::Observable; kwargs...)
    lons = collect(var[]["longitude"])
    lats = collect(var[]["latitude"])
    data = @lift(nomissing(collect($var)))
    
    lons2 = isperiodiclon(lons) ? lonpadview(lons) : lons
    data2 = isperiodiclon(lons) ? @lift(lonpadview($data)) : data
    x,y,z = lonlat2xyz(lons2,lats)

    invert_normals = isa(lons,Vector) ? true : false
    surface!(ax,x,y,z,color=data2, invert_normals = invert_normals; kwargs...)
    
end 

"""
    addequator!(ax; lat=0, kwargs...) 

Adds equator to axis `ax`
"""
function addequator!(ax; lat=0, kwargs...)
    lon = 0:0.25:360
    x,y,z = lonlat2xyz(lon,lat)
    lines!(ax, x, y, z; kwargs...)
end 

"""
    addmeridian!(ax; lon=0, kwargs...) 

Adds meridian at `lon=0` to axis `ax`
"""
function addmeridian!(ax, lon=0; kwargs...)
    lats = -90:0.25:90
    x, y, z = lonlat2xyz([lon], lats)
    lines!(ax, x, y, z; kwargs...)
end 



# Helper functions to extract attributes from Observables 
long_name(var::Observable) =  var[].var.attrib["long_name"]
CommonDataModel.dimnames(var::Observable) =  dimnames(var[])



"""
    x,y,z = lonlat2xyz(lons,lats)

Convert `lons`, `lats` to `x`,`y`,`z` coordinates. 

`lons`, `lats` can be either `Vector` or `Matrix` (for irregular grids in LAM models )
"""
function lonlat2xyz(lons::AbstractVector, lats::AbstractVector)
    x = [cosd(lat)*cosd(lon) for lon in lons, lat  in lats]
    y = [cosd(lat)*sind(lon) for lon in lons, lat  in lats]
    z = [sind(lat)           for lon in lons, lat  in lats]
    return (x, y, z)
end

function lonlat2xyz(lons::Matrix, lats::Matrix)
    x = cosd.(lats).*cosd.(lons)
    y = cosd.(lats).*sind.(lons)
    z = sind.(lats)
    return (x, y, z)
end
  

"""
    isperiodiclon(lons)

Returns `true` if `lons` is a `Vector` and `lons` is periodic. `false` if lons is a `Matrix` (irregular grid LAM model)
"""
isperiodiclon(lons::Vector) = (lons[end] + (lons[2]-lons[1])) % 360 == 0
isperiodiclon(lons::Matrix) = false

"""
    lonpadview(data::Matrix) 
    lonpadview(data::Vector) 
   
Returns a `view` of `data` with the first row (assumed to be the longitude dimensions repeated at the end. 
"""
lonpadview(data::Matrix) = view(data,[1:size(data)[1]...,1],1:size(data)[2])
lonpadview(lon::Vector) = view(lon,[1:length(lon)...,1]) 


# include("precompile.jl")

end
