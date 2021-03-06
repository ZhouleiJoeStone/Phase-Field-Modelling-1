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
N = 32;
D = 1;
c = zeros(N,1);
ctilde = zeros(N,1);
M = 1;  
for i = 1:N
  c(i) = 0.5*(1 + sin(2*pi*M*i/N));
endfor
#plot the initial profile 
plot (c , 'r-');
hold on;
halfN = N/2;
delk = 2*pi/N;
for j= 1:80
  g = 2.*c.*(1-c).*(1-2.*c);
  ghat = fft(g);
  chat = fft(c) ;
  for i = 1:N
    if((i-1)<=halfN)
      k = (i-1)*delk;
    endif
    if((i-1)>halfN)
      k = (i-1-N)*delk;
    endif
    k2 = k*k;
    k4 = k2*k2;
    chat(i) = (chat(i) - (k2*delt*ghat(i)))/(1+(2*k4*delt));
  endfor
  c = real(ifft(chat));
endfor
  plot(c,'g');
print -depsc CH1DFT.eps

printf("Total CPU time : %f seconds\n",(cputime-t));
