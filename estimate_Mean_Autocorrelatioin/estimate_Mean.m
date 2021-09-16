% EE252, Adaptive DSP
% student: An Vo
% 1- Estimation of Signal Mean
% ------------------------------------

clear, close all
N=1024; % N = size of all available data (2^10)
sigma=0.64;
%Noise = std*randn(size) + meanValue; 
x=sigma*randn(size([1:N])); % x is WGN of zero-mean and std=sigma=0.64.
Table=[]; % estimate of stdev & true stdev are saved in Table

% Compare the estimated mean in terms of different block sizes.
loop=0;
for M=[8 32 128 256]; % M= Number of data points per block
    loop=loop+1;
    L=N/M; % L= Number of data blocks
    for k=1:L
        mu(k)=sum( x( 1+(k-1)*M : k*M) )/M; % mu of each block
    end
    
    % estimate of stdev & true stdev for each block size. The bigger block
    % size, the smaller standard deviation. 
    % true block stdev = sqrt(block variance). block variance = sigma^2/M
    Table=[Table; std(mu) sqrt(sigma^2/M)] 
    
    subplot(2,2,loop), plot([1:L],mu,'x'),grid % plot the results
    axis([1 L -1 1]);
    xlabel('Block Number'), ylabel('mu-hat'),
    title(sprintf('M= %d',M))
    mu=[];
end
%title for the group of subplots
sgtitle('Estimated signal mean in different block sizes') 