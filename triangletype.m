% Test 1 Problem 2
% Inputs:
a = input('Please enter a value (in degrees) for angle a. ');
b = input('Please enter a value (in degrees) for angle b. ');
c = input('Please enter a value (in degrees) for angle c. ');

% Value Check:
if (a<=0) || (b<=0) || (c<=0)
    error('All angles must be strictly greater than zero!')
end

% Sum Check:
sum_angle = a + b + c;
if sum_angle ~= 180
    error('The sum of the three angles is not 180 degree!')
end

% Categorize
% Right

if (a==b) && (b==c) && (a==c)
    disp('The triangle is an equilateral triangle.');
    if (a==90) || (b==90) || (c==90)
        disp('And the triangle is a right triangle.')
    end
elseif (a==b) || (b==c) || (c==a)
    disp('The triangle is an isosceles triangle.');
    if (a==90) || (b==90) || (c==90)
        disp('And the triangle is a right triangle.')
    end
elseif (a~=b) && (b~=c) && (c~=a)
    disp('The triangle is a scalene triangle.')
    if (a==90) || (b==90) || (c==90)
        disp('And the triangle is a right triangle.')
    end
elseif (a==90) || (b==90) || (c==90)
    disp('The triangle is a right triangle.')
end

