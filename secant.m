function [ c ] = secant( f, a, b, t )
%Secant Summary of this function goes here
%   Detailed explanation goes here

% Body:
while abs(b-a) > t && (2*abs(b-a))/(abs(a)+abs(b)) > t
    c = a - feval(f,a) * ((b - a)/(feval(f,b) - feval(f,a)));
    a = b;
    b = c;
end
   
% Function End:
end

