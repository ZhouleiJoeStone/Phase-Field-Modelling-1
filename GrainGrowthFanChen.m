%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: Phase field modelling
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
clear all
clf
clc
more off;


Ng = 6;
Kappa = ones (Ng,1);
L = ones(Ng,1);
alpha = 1.0;
beta = 1.0;
gamma = 1.0;

N = 64;
dx = 1.0;

phi = unidrnd(6,N,N);
eta = zeros(Ng,N,N);
gibbs = zeros(Ng,N,N);
gibbshat = zeros(Ng,N,N);
etahat = zeros(Ng,N,N);
 
for i =1:N
  for j =1:N
    eta(phi(i,j),i,j) = 1.0;
  endfor
endfor
b = zeros(N,N);
for m = 1:Ng
  for n = m+1:Ng
    for i = 1:N
      for j = 1:N
          b(i,j) = b(i,j) + eta(m,i,j)*eta(n,i,j);
       endfor
     endfor
   endfor
endfor

mesh (b);
view(2);
pause(0);

halfN = N/2;
delk = 2*pi/N;
dt = 0.5;
sum = 0;

for n = 1:10 
  for m = 1:2
    m 
    for g = 1:Ng
      for i = 1:N
        for j = 1:N
          for k = 1:Ng
            if(k!=g)
               sum = sum + eta(k,i,j)*eta(k,i,j);
            endif
          endfor
          gibbs(g,i,j) = -eta(g,i,j)  + eta(g,i,j)*eta(g,i,j)*eta(g,i,j) + 2*eta(g,i,j)*sum;
          sum = 0;
        endfor
      endfor
      for t = 1:N
        for u =1:N
          tempgibbs(t,u) = gibbs(g,t,u);
          tempeta(t,u) = eta(g,t,u);
        endfor
      endfor 
      tempgibbshat = fft2(tempgibbs); 
      tempetahat = fft2(tempeta);
      for t = 1:N
        for u =1:N
          gibbshat(g,t,u) = tempgibbshat(t,u);
          etahat(g,t,u) = tempetahat(t,u);
        endfor
      endfor
    endfor
     for i = 1:N
       if((i-1)<=halfN) kx = (i-1)*delk;
       elseif((i-1)>halfN) kx = (i-1-N)*delk;
       endif
       for j = 1:N
         if((j-1)<=halfN) ky = (j-1)*delk;
         elseif((j-1)>halfN) ky = (j-1-N)*delk;
         endif
         k2 = kx*kx + ky*ky;
         for g = 1:Ng
           etahat(g,i,j) = (etahat(g,i,j) - L(g)*dt*gibbshat(g,i,j))/(1+2*L(g)*Kappa(g)*k2*dt);
         endfor
       endfor
     endfor
     for g = 1:Ng
       for t = 1:N
        for u =1:N
          tempetahat(t,u) = etahat(g,t,u);
        endfor
      endfor 
       tempeta = real(ifft2(tempetahat));
       for t = 1:N
        for u =1:N
          eta(g,t,u) = tempeta(t,u);
        endfor
      endfor
     endfor
   endfor
   b = zeros(N,N);
   for r = 1:Ng
     for s = m+1:Ng
        for i = 1:N
           for j = 1:N
                b(i,j) = b(i,j) + eta(r,i,j)*eta(s,i,j);
           endfor
        endfor
     endfor
   endfor 
   mesh (b);
   view(2);
   pause(0); 
endfor
  
            
        

