function [ x ] = bisection( f, a, b, t )
%BISECTION: calculates the root of the user-input
%   function f on a closed interval [a,b].

% Initialize Functions:
fa = feval(f,a);
fb = feval(f,b);

% Body:
while abs(b-a) > t && (2*abs(b-a))/(abs(a)+abs(b)) > t
    m = (a+b)/2;
    fm = feval(f,m);
    if (fm*fa) > 0
        a = m;
    else
        b = m;
    end
    x = (a+b)/2;
end
   
% Function End:
end

