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
clc
clf
more off;

function y = W(x)
  y = x*x*x*(10 - 15*x + 6*x*x );
endfunction

function y = Wprime(x)
  y = 3*x*x*(10 -15*x + 6*x*x) + x*x*x*(12*x - 15);
endfunction

N = 64;
halfN = N/2;
r = 10;
c = zeros(N,N);
phi = zeros(N,N);
phihat = zeros(N,N);
chat = zeros(N,N);
for i = 1:N
  for j =1:N
     if(((i-halfN)*(i-halfN) + (j-halfN)*(j-halfN))<r*r)
        c(i,j) = 1.0;
        phi(i,j) = 1.0;
     else
        c(i,j) = 0.02;
        phi(i,j) = 0.0;
     endif
  endfor
endfor

Cprofile = c(:,halfN);
Phiprofile = phi(:,halfN);

plot(Cprofile,'r-;C Initial;');
hold on;
plot(Phiprofile,'b-;Phi Initial;');

print -depsc PPTInitial.eps;

delk = 2*pi/N;
A =1.0;
B= 1.0;
M =1.0;
P = 1.0;
kappa = 1.0;
delt = 0.5;
for m = 1:1
  for n = 1:10
    n
    for i = 1:N
      for j = 1:N
        w = W(phi(i,j));
        if(phi(i,j)<0) w=0;
        elseif (phi(i,j)>1) w =1;
        endif
        hc(i,j) = 2*A*c(i,j)*(1-w) - 2*B*(1-c(i,j))*w;
      endfor
    endfor
    for i = 1:N
      for j =1:N
        wp = Wprime(phi(i,j));
        if(phi(i,j)<0) wp = 0.0;
        endif
        if(phi(i,j) >1) wp =0.0;
        endif
        hp(i,j) = -A*c(i,j)*c(i,j)*wp + B*(1-c(i,j))*(1-c(i,j))*wp + 2*P*phi(i,j)*(1-phi(i,j))*(1-2*phi(i,j));
      endfor
    endfor
    hchat = fft2(hc);
    hphat = fft2(hp);
    chat = fft2(c);
    phihat = fft2(phi);
    for i = 1:N
      if( (i-1) <= halfN ) kx = (i-1)*delk;
      endif
      if((i-1)>halfN)  kx = (i-1-N)*delk;
      endif
      for j = 1:N
        if((j-1)<=halfN) ky = (j-1)*delk;
        endif
        if((j-1)>halfN) ky = (j-1-N)*delk;
        endif
        k2 = kx*kx + ky*ky ;
        k4 = k2*k2;
        chat(i,j) = (chat(i,j) - delt*k2*hchat(i,j))/(1 + 2*k4*delt);
        phihat(i,j) = (phihat(i,j) - delt*hphat(i,j))/(1+2*k2*delt);
       endfor
    endfor
    c = real(ifft2(chat));
    phi = real(ifft2(phihat));       
  endfor
endfor
Cprofile = c(:,halfN);
Phiprofile = phi(:,halfN);
plot(Cprofile,'r-');
hold on 
plot(Phiprofile,'b-');
print -depsc PPTFinal.eps

     

  
