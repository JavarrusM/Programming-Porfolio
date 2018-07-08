function z = f1N(x)
global fcount
fcount = fcount + 1;
z = x(1)^2 - 4*x(1) + x(2)^2 - x(2) - x(1)*x(2);
end
