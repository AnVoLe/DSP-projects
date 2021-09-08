%This function finds decimate by 2
function [y] = decimate_by_2(x,h)

    filtered_x = my_convolution(x,h);
    y=downsample_by_2(filtered_x); 
end

