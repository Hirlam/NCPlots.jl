
## [Getting data](@id getting_data)
# ERA5 

ERA5 data can be downloaded from the [Climate Data Store](https://cds.climate.copernicus.eu/#!/home). Requires an [account](https://cds.climate.copernicus.eu/user/register?destination=%2F%23!%2Fhome)

* [Complete ERA5 global atmospheric reanalysis](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-complete?tab=overview)
* [ERA5 hourly data on pressure levels from 1940 to present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-pressure-levels?tab=overview),
* [ERA5 hourly data on single levels from 1940 to present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-single-levels?tab=overview)
* [ERA5-Land hourly data from 1950 to present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-era5-land?tab=overview)


Click `download data` in one of the datasets to get an overview of the available data. After making a selection click `Show API request` which will give a Python script to download the data. You can also use [CDSAPI.jl](https://github.com/JuliaClimate/CDSAPI.jl) julia package


```julia 
using CDSAPI 

year = 2020
month = 4       # use e.g. 1:12 for all months
day = 1:10      # use e.g. 1:31 for all days in month
times = 0:1:23  # use 0:1:23 for all hours in day(s)

# variable = "mean_sea_level_pressure"  # "surface_pressure"
variable = ["geopotential", "pv"]


CDSAPI.retrieve(
    "reanalysis-era5-pressure-levels",
    Dict(    
        "product_type" =>  "reanalysis",
        "format" => "netcdf",
        "variable" => variable,
        "pressure_level" => "500",
        "time"  =>  lpad.(times,2,"0") .*":00",    # 00:00 00:06 00:12 etc 
        "day"  => lpad.(day,2,"0"),            # 01 02 03 etc ,
        "month" => lpad.(month,2,"0"),         # 01 02 03 etc
        "year" => "$year",
       #   "area" => area  # leave  out for global fields
    ),
    "era5_pressure_levels_$(join(variable,"_")).nc"
)

```

## Arctic regional reanalysis 

Arctic regional reanalysis (CARRA) can be download from the climate data store 

* [Artic regional reanalysis on pressure levels from 1991 to present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-carra-pressure-levels?tab=overview)
* [Arctic regional reanalysis on model levels from 1991 to present](https://cds.climate.copernicus.eu/cdsapp#!/dataset/reanalysis-carra-model-levels?tab=overview)

## MetCoop

Harmonie Arome NetCDF file from Met Norway: 
todo
