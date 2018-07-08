function y = matxvec(A,x)
%UNTITLED7 Summary of this function goes here
% Ensure that A and x are compatible sizes
[rows_A, cols_A] = size(A);
[rows_x, cols_x] = size(x);

if (cols_A~=rows_x)
    error('A and x must be compatible sizes')
end

y = zeros(rows_A,cols_x); % Preallocation - MATLAB sets the right amount of memory

for i = 1:rows_A
    for j = 1:cols_A
        y(i) = y(i) + A(i,j)*x(j);
    end
end

