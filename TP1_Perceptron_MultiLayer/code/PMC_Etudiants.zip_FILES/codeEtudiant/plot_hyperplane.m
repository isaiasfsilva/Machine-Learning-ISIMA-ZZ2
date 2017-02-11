function plot_hyperplane (weights , xr , yr)

if (weights(2) == 0)
    plot ([-weights(3)/weights(1) -weights(3)/weights(1)] , [yr(1) yr(2)]) ;
else
    plot ([xr(1) xr(2)] , [(-weights(3)-weights(1)*xr(1))/weights(2) (-weights(3)-weights(1)*xr(2))/weights(2)]) ;    
end

