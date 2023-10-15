# Animations

Pass in an Observable 

```julia
t = Observables(1)
field = @lift(view(ds(time=$t)["pv"]) 
fig,ax,plt = plot(field)
```


Then animate like 

```julia
for i in 1:100
   t[]=i 
   sleep(0.01)
end 

```

## Recording animations
