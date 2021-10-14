function [N_vect] = hailstoneseq(N)

% Hailstone Sequence:
%Take any natural number n. If n is even, divide it by 2 to
% get n/2. If n is odd, multiply it by 3 and add 1. Repeat the process
% until the number equals 1.

% Input Check:
if (N<1) || (floor(N)~=N)
    error('n must be a natural number.')
end

N_vect = N;
while N_vect(end)~=1
    % Even-Odd Check:
    if mod(N_vect(end),2)==0
        N_vect(end+1) = N_vect(end)/2;
    else
        N_vect(end+1) = N_vect(end)*3+1;
    end
end

% Plot: N_vect
plot((1:length(N_vect-1)), N_vect)

% Plot: N=1
if N==1
    plot(N,'ro')
end

% Graph Accessories
xlabel('Iterations Number')
ylabel('Value of f')
title('Hailstone Sequence')
end

