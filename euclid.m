function [d,m,n] = euclid(a,b)
%EUCLID: This function calculates the greatest common diviosr d of integers
%        a and b. It also calvulates integers m and n such that 
%        d = a*m + b*n.

% - MATH 3600
% - February 14, 2018

% Check
if (a<0) || (b<0)
    error('Integers a and b must be positive.')
end

% Setup
row1 = [a, 1, 0];
row2 = [b, 0, 1];

% Euclid:
while row2(1) ~= 0
    q = floor(row1(1)/row2(1));
    row3 = row1-row2*q; 
    % Backup:
    row1 = row2;
    row2 = row3;
end

% Output:
d = row1(1);
m = row1(2);
n = row1(3);

% Function End:
end

