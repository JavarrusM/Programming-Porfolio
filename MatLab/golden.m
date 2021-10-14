function [c, fc] = golden(f, a, b, t)
%GOLDEN
r = (3 - sqrt(5))/2;
x1 = a + r*(b-a);
x2 = b - r*(b-a);
c = (a + b) / 2;
while abs(b - a) > t && (2*abs(b-a))/(abs(a)+abs(b)) > t
    if feval(f,x1) < feval(f,x2)
        b = x2;
        x2 = x1;
        x1 = a + r*(b-a);
    else
        a = x1;
        x1 = x2;
        x2 = b - r*(b-a);
    end
    c = (a + b)/2;
    fc = feval(f,c);
end

