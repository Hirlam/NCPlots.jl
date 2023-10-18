module NCPlots


using Makie, CommonDataModel, Dates

export plot, plotvar!, addmeridian!, addequator!, lonlat2xyz
export SliderGridElem, Menu

include("slider.jl")

"""
   fig,ax,plt = plot(ds) 

Plots dataset `ds` 

"""
function plot(ds::CommonDataModel.AbstractDataset; kwargs...)
    vars = setdiff(keys(ds), CommonDataModel.dimnames(ds))  
    
    fig = Figure(resolution=(1200,1200), figure_padding=0)
    menu = Menu(fig[1,1], options = vars,default=vars[1]) 
    ax = LScene(fig[2,1], show_axis=false)
    display(fig)
    sel= Observable(vars[1]) 
    field = @lift(view(ds,time=1)[$sel])
    plt = plotvar!(ax,field)
    # cbax = Colorbar(fig[2,1],plt)
    on(menu.selection) do seli
      sel[] = seli
    end 


end 



"""
    fig,ax,plt = plot(var)

Plots variable `var` on the sphere. Returns `fig` `ax` and `plt`. 
"""
function plot(var::Observable{<:CommonDataModel.AbstractVariable{T}}; kwargs...) where T

    fig = Figure(resolution=(1200,1200), figure_padding=0)
    ax = LScene(fig[1,1],show_axis=false)
    plt = plotvar!(ax,var; kwargs...)    

    display(fig)
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
    data = @lift(convert(Matrix{Float64},$var[:,:]))
    
    lons2 = isperiodiclon(lons) ? lonpadview(lons) : lons
    data2 = isperiodiclon(lons) ? @lift(lonpadview($data)) : data
    x,y,z = lonlat2xyz(lons2,lats)

    invert_normals = isa(lons,Vector) ? true : false
    plt = surface!(ax,x,y,z,color=data2, invert_normals = invert_normals; kwargs...)
    
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

function lonlat2xyz(lons::AbstractMatrix, lats::AbstractMatrix)
    x = cosd.(lats).*cosd.(lons)
    y = cosd.(lats).*sind.(lons)
    z = sind.(lats)
    return (x, y, z)
end

lonlat2xyz(lon::Number, lat::Number) = [cosd(lat)*cosd(lon),cosd(lat)*sind(lon),sind(lat)]
lonlat2xyz(lonlat::Vector) = lonlat2xyz(lonlat[1],lonlat[2]) # for two element vector
lonlat2xyz(lonlat::Tuple) = lonlat2xyz(lonlat[1],lonlat[2])  # for two element tuple
lonlat2xyz(lonlat::Vector{Tuple}) = lonlat2xyz.(lonlat[1],lonlat[2]) 


  
#function lonlat2xyz(lonlat::Vector)
#    lon = first.(lonlat)
#    lat = last.(lonlat)
#    x,y,z = lonlat2xyz.(lon,lat)    
#    return x,y,z
#end

"""
    isperiodiclon(lons)

Returns `true` if `lons` is a `Vector` and `lons` is periodic. `false` if lons is a `Matrix` (irregular grid LAM model)
"""
isperiodiclon(lons::AbstractVector) = (lons[end] + (lons[2]-lons[1])) % 360 == 0
isperiodiclon(lons::AbstractMatrix) = false

"""
    lonpadview(data::Matrix) 
    lonpadview(data::Vector) 
   
Returns a `view` of `data` with the first row (assumed to be the longitude dimensions repeated at the end. 
"""
lonpadview(data::AbstractMatrix) = view(data,[1:size(data)[1]...,1],1:size(data)[2])
lonpadview(lon::AbstractVector) = view(lon,[1:length(lon)...,1]) 


# include("precompile.jl")

end
