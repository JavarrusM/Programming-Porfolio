function z = f3(x)
global fcount
fcount = fcount + 1;
z = (x(1)-x(2))/(2+x(1)^2+x(2)^2);
end
