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

t = cputime;
delt = 0.5;
Nx = 64;Ny = 64;
D = 1;
c = zeros(Nx,Ny);
ctilde = zeros(Nx,Ny);
M = 1;  
for i = 1:Nx
  for j = 1:Ny
    c(i,j) = 0.5 + 0.1*(0.5 - rand());
  endfor
endfor
%plot the initial profile 
mesh(c);
view(2);
pause(0);

halfNx= Nx/2;
halfNy = Ny/2;
delkx= 2*pi/Nx;
delky = 2*pi/Ny;

A = 1.0;
M = 1.0;
kappa = 1.0;

for m = 1:10
  for n = 1:20
    g = 2*A.*c.*(1-c).*(1-2.*c);
    ghat = fft2(g);
    chat = fft2(c);
    for i = 1:Nx
      if (i<= halfNx ) kx = (i-1)*delkx;
      endif
      if (i > halfNx) kx = (i-1-Nx)*delkx;
      endif
      for j =1:Ny
        if (j<= halfNy ) ky = (j-1)*delky;
        endif
        if (j  > halfNy ) ky = (j-1-Ny)*delky;
        endif
        k2 = kx*kx + ky*ky;
        k4 = k2*k2;
        chat(i,j) = (chat(i,j) - M*delt*k2*ghat(i,j))/(1 + 2*M*kappa*k4*delt);
      endfor
    endfor
    c = real(ifft2(chat));     
   endfor
   mesh(c);
   view(2);
   pause(0);
endfor
print -depsc CH2DFT.eps

printf("Total CPU time : %f seconds\n",(cputime-t));
