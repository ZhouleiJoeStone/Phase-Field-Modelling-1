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
clf
clear 

t  = cputime ;
%not dimensionalised numbers
delt = 0.1;
delx = 0.5;
D = 1.0;
alpha = D*delt/(delx*delx);

%initial conditions 
% c(1) = C_0 and the remoining is 0.0
c = zeros(101,1);
c_t = zeros(101,1);
c(1) = 1;
c(101) = 0;
c_t(1) = 1;
c_t(101) = 0;
%plot the initial profile
plot (c, 'r-;Initial profile;');

%get handle 
ax = gca ;
set(ax, "linewidth",2.0);
axis("square");

%hold the plot 
hold on

% Compostion evolution
for k = 1:20 %this is for plotting 
  for j = 1:500
    for i = 2:100
      c_t(i) =  c(i)*(1 - 2*alpha) + alpha*(c(i-1) + c(i+1) );
    endfor %ending i loop
    c = c_t;
  endfor %ending j loop
  plot (c )
endfor % ending k loop

% Save figure
print -depsc Explicit1D0C.eps

printf('Total cpu time: %f seconds\n', cputime-t);
