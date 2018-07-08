function [ b ] = brent(f,a,b,t)
%BRENT: The purpose of Brent’s method is to calculate the root of a function on a closed interval
%   [a,b] in a very efficient manner, which means that we don’t want to evaluate the function
%   more than we need to. It turns out that you can program Brent’s method very, very
%   incorrectly, and it will still work, just not very efficiently.


if feval(f,a) * feval(f,b) >= 0
    error('f(a)and f(b) must be opposite signs.')
end
if abs(feval(f, a)) < abs(feval(f,b))
    swap = a;
    a = b;
    b = swap;
end
c = a;
mflag = 1;
while abs(b - a) > t && (2*abs(b-a))/(abs(a)+abs(b)) > t
    delta = 2 * eps * abs(feval(f, b)) + t/2;
    if feval(f, a) ~= feval(f, c) && feval(f, b) ~= feval(f, c)
        s = (a*feval(f,b)*feval(f,c))/((feval(f,a) - feval(f,b)) * (feval(f,a) - feval(f,c)));
        s = s + (b*feval(f,a)*feval(f,c))/((feval(f,b) - feval(f,a)) * (feval(f,b) - feval(f,c)));
        s = s + (c*feval(f,a)*feval(f,b))/((feval(f,c) - feval(f,a)) * (feval(f,c) - feval(f,b)));
        disp('Inverse Quadratic Interpolation')
    else
        s = b - feval(f,b) * ((b - a)/(feval(f,b) - feval(f,a)));
        disp('Secant Method')
    end
    if (s > (3*a + b)/4 && s > b) || (s < (3*a + b)/4 && s < b) ||...
            (mflag == 1 && abs(s-b) >= abs(b-c)/2) ||...
            (mflag == 0 && abs(s-b) >= abs(c-d)/2) ||...
            (mflag == 1 && abs(b-c) && abs(b-c) < abs(delta)) ||...
            (mflag == 0 && abs(c-d) < abs(delta))
        s = (a + b)/2;
        mflag = 1;
        disp('Bisection Method')
    else
        mflag = 0;
    end
    d = c;
    c = b;
    if feval(f, a) * feval(f, s) < 0
        b = s;
    else
        a = s;
    end
    if abs(feval(f,a)) < abs(feval(f,b))
        temp = a;
        a = b;
        b = temp;       
    end
% While Loop End:
end
% Function End:
end

