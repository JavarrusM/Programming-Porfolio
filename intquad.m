disp('This script file calculates the value of the integral ')
disp('of Ax^2 + Bx + C from L to R.')
disp(' ')
A = input('Please enter A. ');
B = input('Please enter B. ');
C = input('Please enter C. ');
L = input('Please enter the left endpoint L. ');
R = input('Please enter the right endpoint R. ');
Ans = (A*R^3)/3 + (B*R^2)/2 + C*R -((A*L^3)/3 + (B*L^2)/2 + C*L);
fprintf('The value of the integral is %.6f\n',Ans)
