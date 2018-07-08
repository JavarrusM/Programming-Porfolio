function [T] = clumps(N,x)
%CLUMPS: Determine the number of trials it takes to reach N successes.
% - MATH 3600
% - February 16, 2018

% Setup:
T = 0;
S = 0;

% clumps:
while S ~= N
    T = T + 1;
    if x(T) == 1
        S = S + 1;
    else
        S = 0;
    end
end
    
% Function end:
end

