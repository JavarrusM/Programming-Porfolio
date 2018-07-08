function [S] = powerint(A, p, b, a)
% powerintegrator: calculates the value of the definite integral

% Value Check
if length(A) ~= length(p)
    error('The length of the coefficient vector must equal the length of the vector of exponents.')
end

% Definite Integral Setup:
S = 0;

% Definite Integral:
for i = 1:length(A)
    if p(i) == -1
        S = S + A(i)*(log(a)-log(b));
    else
        S = S + A(i)/(p(i)+1)*(a^(p(i)+1)-b^(p(i)+1));
    end
end

% Plot Setup:
x = linspace(b,a,(a-b)*100);
y = zeros((a-b)*100,1);
for i = 1:(a-b)*100
    for j = 1:length(A)
        y(i) = y(i) + A(j)*x(i)^p(j);
    end
end

% Plot
plot(x,y)
end


