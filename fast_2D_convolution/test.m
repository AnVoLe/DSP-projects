%given input x and impulse response h, find output y.
x=[1 6 3 1 4 5];
h=[1 2 4 6 4 5 2];

%compute convolution using my_conv function
y=my_conv(x,h)
%plot convolution result
stem(y)