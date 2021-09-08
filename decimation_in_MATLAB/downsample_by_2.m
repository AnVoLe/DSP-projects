%This function downsamples by 2
function [y] = downsample_by_2(x)

    n=length(x); % length of input
    m=fix((n+1)/2); % length of decimate output
    y=zeros(1,m); %initalize the output vector
    
    for i=1:m
        y(i)=x(2*i-1);
    end
end