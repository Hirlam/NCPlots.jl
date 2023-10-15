import cdsapi

c = cdsapi.Client()

c.retrieve(
    'reanalysis-era5-pressure-levels',
    {
        'product_type': 'reanalysis',
        'format': 'netcdf',
        'variable': [
            'geopotential', 'potential_vorticity',
        ],
        'pressure_level': '500',
        'year': '2020',
        'month': '01',
        'day': '01',
        'time': '12:00',
    },
    'era5_pv_z_500hPa.nc')
