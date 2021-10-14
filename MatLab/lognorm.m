function [S] = lognorm(s,x)
%LOGNORM: that models the growth of a stock over several time steps. We 
%         will model the growth of a stock given the initial value, which 
%         we will call S0, and a vector x of values for X.

% - MATH 3600
% - February 16, 2018

% Setup: (Initialization)
n_x = length(x);
S = zeros(1,n_x+1);
S = s;

% lognorm: (Body of function)
for i = 1:n_x
   S(end+1) = S(end)*exp(x(i));
end

% Function End:
end

