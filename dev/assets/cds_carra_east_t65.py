
import cdsapi

c = cdsapi.Client()

c.retrieve(
    'reanalysis-carra-model-levels',
    {
        'format': 'netcdf',
        'domain': 'east_domain',
        'variable': 'temperature',
        'model_level': '65',
        'time': '12:00',
        'product_type': 'analysis',
        'year': '2020',
        'month': '01',
        'day': '01',
    },
    'carra_east_t65.nc')

