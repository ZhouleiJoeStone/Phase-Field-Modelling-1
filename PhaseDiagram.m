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

x = 0.001:0.001:0.999;
alpha(1) = 2.01;
alpha_lim = 100
for i = 1:alpha_lim
  c(i) = fminbnd(@(x) gibbs(x,alpha(i)),0.001,0.499,optimset('TolX',1.e-12));
  d(i) = fminbnd(@(x) gibbs(x,alpha(i)),0.501,0.999,optimset('TolX',1.e-12));
  e(i) = fzero(@(x) gibbsdd(x,alpha(i)), [0.001,0.499]);
  f(i) = fzero(@(x) gibbsdd(x,alpha(i)), [0.501,0.999]);
  alpha(i+1) = alpha(i) + 0.01;
endfor

for i = 1:alpha_lim
  b(i) =  alpha(i);
endfor

plot(c,1./b);
hold on; 
plot(d,1./b);
plot(e,1./b);
plot(f,1./b);


  
