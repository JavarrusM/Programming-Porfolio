function [ L ] = binarytuble( N )
%BINARYTUPLE that takes as input a nonnegative integer N and outputs a list
%L of all the binary N-tuples of length N

% Check:
if N < 0 || N ~= floor(N)
    error('N needs to be a nonnegtive integer!')
end

% Setup:
STACK = cell(1);
L = zeros(2^N,N);
count = 0;

% BINARYTUPLE:
while isempty(STACK)
    X = STACK{END};
    if length(X) == L
        count = count + 1;
        L(count,) = X;
    else
        STACK{END+1} = [X,1];
        STACK{END+1} = [X,0];
    end
end

% Function End:
end

