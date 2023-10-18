# Animations



## Animated plots

To make these animations use Observables and `@lift` to lift the dataset view e.g.

```julia 
ds = Dataset(...) 
t = Observable(1)
pv = @lift(view(ds,time=$t)["pv"]) 
plot(pv) 
```

Updating `t` wil update the plot e.g.

```julia
for i=1:100
   t[] = i
   sleep(0.01)
end 
```

![](../assets/pv_era5_2.gif)

You can access eyeposition in `ax.scene` and update in the for loop  

![](../assets/test.mp4)

## Recording animations
