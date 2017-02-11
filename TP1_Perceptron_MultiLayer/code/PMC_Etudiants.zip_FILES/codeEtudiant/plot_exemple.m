function plot_pattern (dims , pattern , class)


hold on

markers = ['+','o','*','x','s','d','p','h'] ;
colors = ['r','g','b','m','c','y','r','v'] ;

if (size(dims) == 3)
    for i = 1:size(pattern,1)
        cl = strcat(markers(class(i)+1),colors(class(i)+1)) ;
        plot3 (pattern(i,dims(1)) , pattern(i,dims(2)) , pattern(i,dims(3)) , cl) ;
    end
else
    for i = 1:size(pattern,1)
        cl = strcat(markers(class(i)+1),colors(class(i)+1)) ;
        plot (pattern(i,dims(1)) , pattern(i,dims(2)) , cl) ;
    end
end

grid on


