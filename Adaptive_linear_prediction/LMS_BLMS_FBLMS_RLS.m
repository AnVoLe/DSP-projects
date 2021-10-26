% Adaptive Linear Prediction using LMS, RLS
% block implementation of LMS in time domain and frquency domain
% read from F-B book, chapter 8
clear, close all
n=(1:1000);
N=length(n);% length of the available data

v=randn(N,1); % unit variance white noise
x=filter(1,[1 -1.2728 0.81],v); % primary signal

mu=0.005; %LMS step
rho =1;  % Exponential (memory) factor for RLS
M=2; % filter of 2 taps.
W1=zeros(M,1); % Initialize 2 LMS weights to zero;
W2=zeros(M,1); % Initialize 2 RLS weights to zero;
W3=zeros(M,1); % Initialize 2 BLMS weights to zero;
W4=zeros(M,1); % Initialize 2 FBLMS weights to zero;
W_lms=zeros(2,N); % LMS Weights storage during iterattions
W_rls=zeros(2,N); % RLS Weights storage during iterattions
W_blms=zeros(2,N); % BLMS Weights storage during iterattions
W_fblms=zeros(2,N); % FBLMS Weights storage during iterattions

%Initialize output
y=zeros(1,N);
e=y;
y_blms=y;
e_blms=e;
y_fblms=y;
e_fblms=e;

eta=1e5;    % Arbitrary large positive constant
R_inv = eta*eye(M);     % Initialize R_inv for RLS
L=10; % Block size for BLMS
cnt=0; %  counter for BLMS
cnt1=0; %  counter for FBLMS

P_0L=zeros(L+M-1);
P_0L(M:end,M:end)=eye(L);%  P_OL for FBLMS calculating the filter output, eqn (8.36) p.259 
w_0FB=[W4;zeros(L-1,1)];  % eqn (8.19) p.256
w_fft=fft(w_0FB);
P_N0=zeros(L+M-1);
P_N0(1:M,1:M)=eye(M);%  P_N0 for FBLMS updating the weights, eqn (8.45) p.260
P_N0=dftmtx(L+M-1)*P_N0*inv(dftmtx(L+M-1)); % eqn (8.45). it should be done via FFT

% Iterate
for k=M+1:1:N % k=3,4,...,1000

    X=x(k-1:-1:k-M); % X is a vector containing x(k-1),.., X(K-M)
    %% LMS algorithm
    y(k)=W1'*X; % filter output y, or  estimate of x
    e(k)=x(k)-y(k); %
    W1=W1+2*mu*e(k)*X; % Update weight vector
    
    W_lms(1,k)=W1(1);    % save weights 
    W_lms(2,k)=W1(2);
    
    %% BLMS algorithm implemeted in time domain
    cnt=cnt+1;
    xB(:,cnt)=X;
    dB(cnt)=x(k);
    if cnt==L
        yB=W3'*xB;
        eB=dB-yB;      
        W3=W3+2*mu*xB*eB';
        cnt=0;
    end
    W_blms(1,k)=W3(1);    % save weights 
    W_blms(2,k)=W3(2);
    
    %% FBLMS algorithm implemeted in frequency domain using overlap save method
    cnt1=cnt1+1;
    xFB(cnt1)=x(k-1);       %  data block vector
    dFB(cnt1,:)=x(k);       % desired data block vector
    if cnt1==L     
        
        % filtering, find filter output
        x_0FB= [x(k-(L+M-1)) xFB]';  % extended data block vector
        x_fft=fft(x_0FB); 
        y_0FB=ifft(x_fft.*w_fft);  % extended filter output vector
        yFB=y_0FB(end-L+1:end); % filter output vector,the last L elements
   
        % error estimate
        e_FB=dFB-yFB;
        e_0FB=[zeros(M-1,1); e_FB]; % extended error vector
        
        % tap-weight update
        e_fft=fft(e_0FB);
        %eqn (8.47) p.260. update weights in frequency domain, because we
        %only use weights in frequency domain to find filter outputs
        w_fft=w_fft+2*mu*conj(x_fft).*e_fft;
        w_0FB=ifft(w_fft);
        w_0FB(end-L+2:end)=0; %make sure L-1 weights in time domain are zeros
        w_fft=fft(w_0FB);     
        cnt1=0;        
    end
    W4=ifft(w_fft(1:2,:));
    W_fblms(1,k)=w_0FB(1);    % save weights 
    W_fblms(2,k)=w_0FB(2);    
    
    
    %% RLS algorithm    
    y(k)=W2'*X; % filter output y, or  estimate of x
    e(k) = x(k)-y(k); % A priori error e(k)
    
    Z=R_inv*X;          % Filtered reference vector
    q=X'*Z;             % Normalized error power q
    v= 1/(rho+q);
    Z_t = v*Z; % Normalized filtered reference vector
    W2= W2 + e(k)*Z_t;
    R_inv = (R_inv - Z_t*Z')/rho;
    
    W_rls(1,k)=W2(1);    % save weights 
    W_rls(2,k)=W2(2);
end

% plot LMS weights over iterations
subplot(4,1,1),plot(n,W_lms(1,:),n,W_lms(2,:))
xlabel('Iteration, k'),ylabel('weights ')
title('Weights updated during LMS iterations')
% plot desired weights
yline(1.2728,'--'); yline(-0.81,'--');
legend("W(1)","W(2)"),ylim([-1.5 2])

% plot RLS weights over iterations
subplot(4,1,2),plot(n,W_rls(1,:),n,W_rls(2,:))
xlabel('Iteration, k'),ylabel('weights ')
title('Weights updated during RLS iterations')
% plot desired weights
yline(1.2728,'--'); yline(-0.81,'--');
legend("W(1)","W(2)"),ylim([-1.5 2])

% plot BLMS weights over iterations
subplot(4,1,3),plot(n,W_blms(1,:),n,W_blms(2,:))
xlabel('Iteration, k'),ylabel('weights ')
title('Weights updated during BLMS iterations')
% plot desired weights
yline(1.2728,'--'); yline(-0.81,'--');
legend("W(1)","W(2)"),ylim([-1.5 2])

% plot FBLMS weights over iterations
subplot(4,1,4),plot(n,W_fblms(1,:),n,W_blms(2,:))
xlabel('Iteration, k'),ylabel('weights ')
title('Weights updated during FBLMS iterations in Frequency domain')
% plot desired weights
yline(1.2728,'--'); yline(-0.81,'--');
legend("W(1)","W(2)"),ylim([-1.5 2])

