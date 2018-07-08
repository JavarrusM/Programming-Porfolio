function [ X,Y ] = QLS( f,a,b,c,t )
%QLS - The objective of this exercise is to write the function QLS.m, which
%   implements a way of calculating the minimum on [a,b].

% Body
while abs(b-a) > t && 2 * abs(b-a)/(abs(a)+abs(b)) > t
    d = (1/2) * ...
        ((c^2 - b^2)*feval(f,a) + (b^2 - a^2) * feval(f,c) + (a^2 -c^2) * feval(f,b)) /...
        ((c-b) * feval(f,a) + (b-a) * feval(f,c) + (a-c)*feval(f,b));
    if feval(f,c) < feval(f,d)
        b = d;
    else
        a = c;
        c = d;
    end
    
    % Outputs:
    X = (a+b)/2;
    Y = feval(f,X);    
    % While End:
end
% Function End:
end

