function [ X ] = banach( N,V )
%BANACH - The objective of this assignment is to write the user-defined MATLAB function banach.m
%    that simulates this problem. Given a positive integer N, which represents the
%    number of matches in both boxes at the start, and a vector V of random numbers, simulate
%    the drawing of a match until one matchbox is empty. The output will be the number of
%    matches in the “other” box when one matchbox first becomes empty. Here’s how it will
%    work.

% Initialize:
LM = N;
RM = N;

% Body:
for x = V
    if x < 0.5
       LM = LM - 1;
       if LM == 0
           X = RM;
           return
       end
    else
        RM = RM - 1;
        if RM == 0
            X = LM;
            return
        end
    end
% For End:    
end
% Function End:
end

