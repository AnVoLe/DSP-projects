% EE210,Linear system 
% Student: An Vo
% -------------------------------------------------------------------------
% discrete convolution using tabular method
% ---------------------------------

function [y] = my_conv(x,h)
    n=length(x);
    m=length(h);
    x_overlap=zeros(1,m); % the part of vector x overlaps within the vector h
    y=zeros(1,m+n-1); %initalize the output vector length m+n-1
    
    % for loop to find output values for each index. 
    for i=1:(m+n-1)
        %find the 1st element of the vector x_overlap.
        %if i<= n, length of x, the 1st element is updated as x(i)
        %if i> n, the 1st element is updated as 0.
        if i<=n
            x_overlap(1)=x(i);
        else 
            x_overlap(1)=0;
        end
        
        %find the convolution result at the index i.
        y(i)=x_overlap*h';
        
        %find 2nd -> end elements of the vector x_overlap to find the next output value.  
        x_overlap(2:end)=x_overlap(1:end-1);
    end 
    
end