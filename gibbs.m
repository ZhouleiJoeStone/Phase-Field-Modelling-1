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
function y = gibbs(x,a) 
  y = a.*x.*(1-x) + x.*log(x) + (1-x).*(log(1-x));
endfunction
