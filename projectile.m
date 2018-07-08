function [  ] = projectile( h,v )
%PROJECTILE - The objective is to write the user-defined MATLAB function projectile.m that takes as
%   input variables the initial height h0 and the initial velocity v0 and calculates the following:
%   1. the object’s maximum height,
%   2. the time the object stays in the air, and
%   3. the velocity of the object when it strikes the ground.

% Initialize:
g = -9.81; % gravity
a = g/2; b = v; c = h; % Quadrativ Variables
t1 = (-b + sqrt(b^2 - 4 * a * c)) / (2 *a);
t2 = (-b - sqrt(b^2 - 4 * a * c)) / (2 *a);
tvect = [t1, t2];
tf = max(tvect);

% Plot Variables:
trange = linspace(0,tf,1000);
tmax = -v/g;
y1 = g / 2 * trange.^2 + v*trange + h;

% Plots:
hold off
plot(trange, y1) % Plot 1
hold on
plot(0,h,'ro') % Plot 2
hold on
y2 = g / 2 * tmax^2 + v*tmax + h;
plot(tmax, y2, 'rs') % Plot 3
hold on
plot(tf, 0, 'r*') % Plot 4

% Plot Accesories:
title('Projectile Motion Neglecting Air Resistance')
xlabel('Time')
ylabel('Height')
legend('Height as a Function of TIme', 'Initial Height', 'Maximum Height', 'Time in the Air')

% End Statements:
fprintf('The maximum height of the object is %.3f meters.\n', y2)
fprintf('The object is in the air %.3f seconds.\n', tf)
finv = g * tf + v;
fprintf('The velocity of the object when it hits the gorund is %.3f meters/second.\n', finv)
hold off

% Function End:
end

