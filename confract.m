function [x] = confract(a,b)
%CONFRACT: Calculates the value of a given continued fraction, where the
%          coefficients are input by the user. The inputs will be two arrays,
%          a and b. The output will be the value of the continued fraction.

% - MATH 3600
% - February 16, 2018

% Check:
if length(a) - length(b) ~= 1
    error('The lengths of vectors a and b are not compatible.')
end

% Setup:
x = a(end);

% Confract:
for i = length(b):-1:1
    x = a(i) + b(i)/x;
end

% Function End:
end

