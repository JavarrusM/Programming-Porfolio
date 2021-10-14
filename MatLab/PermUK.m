function [ M ] = PermUK(N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Check:
if N<0 && N == floor(N)
    error("Input N needs to be a positive integer!")
end

% Setup:
M = zeros(N+1,N+1);
P = [1:N+1];
M(1,:) = P;
count = 2;

% Body:
% if Inverse
    for i = (N+1):-1:2
        tempN = P(i);
        tempSub = P(i-1);
        P(i) = tempSub;
        P(i-1) = tempN;
        M(count,:) = P;
        count = count + 1;
    end
%else
    %for i = 1:N
        %tempN = P(i);
        %tempSub = P(i+1);
        %P(i) = tempSub;
        %P(i-1) = tempN;
        %M(count,:) = P;
        %count = count + 1;
%end
    
% Function End:
end

