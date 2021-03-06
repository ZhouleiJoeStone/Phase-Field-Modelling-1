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
clear 
clf

t = cputime;
delt = 0.5;
dx = 1.0;
N = 128;
L = 1.0;
A = 1.0;
kappa = 1.0;
phi = zeros(N,1);
for i = (N/4) + 1 : 3*(N/4)
  phi(i) = 1.0;
endfor
plot(phi,'r-;Initial;');
hold on;
halfN = N/2;
delk = 2*pi/N;
for m= 1:400 
  g = 2*A.*phi.*(1-phi).*(1-2.*phi);
  ghat = fft(g);
  phihat = fft(phi ) ;
  for i = 1:N
    if((i-1)<=halfN)
      k = (i-1)*delk;
    endif
    if((i-1)>halfN)
      k = (i-1-N)*delk;
    endif
    k2 = k*k;
    phihat(i) = (phihat(i) - L*delt*ghat(i))/(1+ 2*kappa*L*delt*k2);
  endfor
  phi = real(ifft(phihat));
endfor
plot(phi,'g'); 
print -depsc AC1DFT.eps
