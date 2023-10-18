
using OrderedCollections 
#CDSdatasets = Dict(
ERA5pl = OrderedDict(
    "product_type" => MultiSelectMenu(["ensemble_mean", "ensemble_members", "ensemble_spread", "reanalysis"]),
    "variable" => MultiSelectMenu([
        "divergence", "fraction_of_cloud_cover", "geopotential",
        "ozone_mass_mixing_ratio", "potential_vorticity", "relative_humidity",
        "specific_cloud_ice_water_content", "specific_cloud_liquid_water_content", "specific_humidity",
        "specific_rain_water_content", "specific_snow_water_content", "temperature",
        "u_component_of_wind", "v_component_of_wind", "vertical_velocity", "vorticity"
    ],pagesize=16),
    "pressure_level" => MultiSelectMenu([
        "1", "2", "3", "5", "7", "10", "20", "30", "50", "70", "100", "125", "150", "175", "200",
        "225", "250", "300", "350", "400", "450", "500", "550", "600", "650", "700", "750",
        "775", "800", "825", "850", "875", "900", "925", "950", "975", "1000",
    ],pagesize=24),
    "year" => MultiSelectMenu(string.(1940:2023), pagesize=24),
    "month" => MultiSelectMenu(lpad.(1:12, 2, "0"), pagesize=12),
    "time" => MultiSelectMenu(lpad.(0:23, 2, "0") .* ":00", pagesize=24),
    "format" => RadioMenu(["netcdf", "grib"])
    # "area" => 
)


# ds = request("Select dataset", RadioMenu(collect(keys(CDSdatasets))))

# ds = CDSdatasets["ERA5 hourly data on pressure levels from 1940 to present"]

ds = ERA5pl

cdsrequest = Dict()

for key in keys(ds)
     choices = request("Select $key", ds[key])
     cdsrequest[key] = ds[key].options[collect(choices)]
end

