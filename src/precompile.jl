



@setup_workload begin 
   @compile_workload begin 
       pvz =  "$(dirname(pathof(NCPlots)))/../docs/assets/era5_pv_z_500hPa.nc"
       ds = Dataset(pvz)
       field = view(ds,time=1)["pv"]

       NCPlots.plot(field,colormap=:RdBu,colorrange=(-2e-6,2e-6))
   end 

end 
