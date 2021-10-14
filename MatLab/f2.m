function z = f2(x)
global fcount
fcount = fcount + 1;
z = x(1)^3 + x(2)^3 - 3*x(1) - 3*x(2) + 5;
end