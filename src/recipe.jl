


#####
#  Note this recipe is currently not used 
#####

@recipe(DsPlot,var) do scene
    Attributes(
        colormap = Reverse(:RdBu),
        #colorrange=(-1,1)
    )
end


function Makie.plot!(p::DsPlot{<:Tuple{<:CommonDataModel.AbstractVariable}})

    var = p[:var]
    @assert dimnames(var[]) == ("longitude", "latitude")
   
    lons  = collect(var[]["longitude"])
    lats  = collect(var[]["latitude"])
    invert_normals = isa(lons,Vector) ? true : false
    x,y,z = lonlat2xyz(lons,lats)
    data = @lift(nomissing(collect($var)))
    
    @show typeof(data)
    surface!(p,x,y,z,color=data,
        colormap = p[:colormap],
        # colorrange = p[:colorrange],
        invert_normals = invert_normals,
    )
    @show propertynames(p.model)
    return p
end
