
"""
     SliderGridElem(dim)

Returns elements to be used in `SliderGrid`

Example usage
slg = SliderGrid(fig[1,1], SliderGridElem(ds["time"])
dsv = @lift(view(ds,time=$(slg[1].value))["elem"])
"""



function SliderGridElem(dim::CommonDataModel.AbstractVariable)
    @assert length(dimnames(dim)) == 1 
    dimname = dimnames(dim)[1]
    datetimeformat = x-> Dates.format(dim[x],"yyyymmddHH")
    format = dimname=="time" ? datetimeformat : x -> "$x"
   return (label = dimname,  range = 1:length(dim), format=format)
   
end

function Menu(fig, dim::CommonDataModel.AbstractVariable)
    @assert length(dimnames(dim)) == 1 
    Makie.Menu(fig,options=zip(dim[:],1:length(dim[:])),default=1)
end 