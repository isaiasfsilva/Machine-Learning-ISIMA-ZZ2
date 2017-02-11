function plot_output (dims , pattern , class , val)


hold on

colors = ['r','g','b','m','c','y','r','v'] ;

mm = 'v' ;
if (abs(val) > 0.5)
    mm = '^' ;
end

cl = strcat(mm,colors(class+1)) ;
if size(dims) == 3
    plot3 (pattern(dims(1)) , pattern(dims(2)) , pattern(dims(3)) , cl) ;
else
    plot (pattern(dims(1)) , pattern(dims(2)) , cl) ;
end
