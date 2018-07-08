% Test 1 Problem 1
% Actual:
x1 = 1790:10:1950;
y1 = [3929000, 5308000, 7240000, 9638000, 12866000,17069000, 23192000,  31443000, 38558000, 50156000, 62948000, 75995000, 91972000, 105711000, 122775000, 131669000, 150697000];

% Theoretical:
x2 = linspace(1790,1950,10000);
y2 = 197273000./(1+exp((-0.03134)*(x2-1913.25)));

% Graph:
plot(x1,y1,'ro')
hold on
plot(x2,y2,'b')

% Accessories:
xlabel('Year')
ylabel('Population')
title('United States Population from 1790 until 1950.')
legend('Actual Population', 'Logistical Least Squares Curve', 'location','northwest')