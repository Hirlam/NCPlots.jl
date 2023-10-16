
"""
     SliderGridElem(dim)

Returns elements to be used in `SliderGrid`
"""



function SliderGridElem(dim::CommonDataModel.AbstractVariable)
    @assert length(dimnames(dim)) == 1 
    dimname = dimnames(dim)[1]
    datetimeformat = x-> Dates.format(dim[x],"yyyymmddHH")
    format = dimname=="time" ? datetimeformat : x -> "$x"
   return (label = dimname,  range = 1:length(dim), format=format)
   
end

