% Quadratic Max and Min

% Script:
disp('This MATLAB script prompts the user to enter')
disp('real numbers A, B, C, L and R then calculates and displays')
disp('the minimum value of the function f(x) = Ax^2 + Bx + C')
disp('on the closed interval [L,R] and the values of x at which')
disp('the function achieves its maximum and minimum.')
fprintf('\n')

% Function: f(x) = Ax^2 + Bx + C
A = input('Please enter the value for A. ');
B = input('Please enter the vlaue for B. ');
C = input('Please enter the value for C. ');

% Interval: [L,R]
L = input('Please enter the value for L. ');
R = input('Please enter the value for R. ');
fprintf('\n')

% Derivative: f(x) = 2Ax + B | Equation: x = (-B/(2*A))
x = (-B/(2*A));
xval = A*x^2 + B*x + C;
lval = A*L^2 + B*L + C;
rval = A*R^2 + B*R + C;

% Max/Min:
if (x<L) || (x>R)
    if lval > rval
        maxval = lval;
        max = L;
        minval = rval;
        min = R;
    else
        maxval = rval;
        max = R;
        minval = lval;
        min = L;
    end
end

% lval
if (x>L) && (x<R)
    if (lval > rval) && (lval > xval)
        maxval = lval;
        max = L;
        if xval < rval
            minval = xval;
            min = x;
        else
            minval = rval;
            min = R;
        end
% rval
    elseif (rval > lval) && (rval > xval)
        maxval = rval;
        max = R;
            if xval < lval
                minval = xval;
                min = x;
            else
                minval = lval;
                min = L;
            end
% xval
    else
        maxval = xval;
        max = x;
            if lval < rval
                minval = lval;
                min = L;
            else
                minval = rval;
                min = R;
            end
    end
end

% Print:
fprintf('The maximum value of the function f(x) = %0.4f*x^2 + %0.4f*x + %0.4f\n',A,B,C)
fprintf('on the interval [ %0.4f, %0.4f]\n',L,R)
fprintf('equals %0.4f and occurs when x = %0.4f,\n',maxval, max)
fprintf('and the minimum value equals %0.4f and occurs when x = %0.4f.\n',minval, min)

