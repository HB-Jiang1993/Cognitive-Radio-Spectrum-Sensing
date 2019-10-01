clc; 
close all;
clear all;
%This program is for optimization of spectrum sensing in 
%Cognitive radio network.
N=20;
j=1;
tt=[];
err2=[];
Pmi=[];
Pdc=[];
error=[];
err1=[];
K=10;
snr=10;
Qd=0;
Qf=0;
tt=10:0.5:60;
vec=['-+','-o','-v','-d','->','-x','-s','-<','-*','-^'];

for n=1:1:10
    
s=ones(1,N);
w=randn(1,N); 

u=N/2;                    %Time-delay bandwidth product

for t=10:0.5:60 
  
Qd=0;
Qf=0;
SNR=10^(snr/10);   %for linear scale 

a=sqrt(2*SNR);
b=sqrt(t);

Pd = marcumq(a,b,u );         % AVG. PROB OF DETECTION(computes the generalized Marcum Q)

Pf = gammainc((t/2),u,'upper');% AVG. PROB OF FALSE ALARM(compute incompelete gamma function)

Pm=1-Pd;                %AVG. PROB OF MISSED DETECTION OVER AWGN
for l=n:1:K
Qd=Qd+(factorial(K)*(Pd^l)*((1-Pd)^(K-l))/(factorial(l)*factorial(K-l)));
Qf=Qf+(factorial(K)*(Pf^l)*((1-Pf)^(K-l))/(factorial(l)*factorial(K-l)));
end

Qm=1-Qd;
err=Qf+Qm;
err1=[err1 err];
end

end
l=1;
i=1;
for j=1:1:10
semilogy(tt,err1(i:i+100),vec(l:l+1),'LineWidth',1.5)
i=i+101;
l=l+2;
hold on;
end
grid on;
ylabel('Total Error rate');
xlabel('Threshold');
legend('n=1','n=2','n=3','n=4','n=5','n=6','n=7','n=8','n=9','n=10');
