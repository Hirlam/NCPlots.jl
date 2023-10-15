



@setup_workload begin 
   pvz =  "$(dirname(pathof(NCPlots)))/../docs/assets/era5_pv_z_500hPa.nc"
   @compile_workload begin 
       ds = Dataset(pvz)
       field = view(ds,time=1)["lsm"]

       NCPlots.plot(field,colormap=:RdBu,colorrange=(0,1))
   end 

end 
