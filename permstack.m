function [ L ] = permstack( N )
%PERMSTACK Summary of this function goes here
%   Detailed explanation goes here
count = 0;
STACK = {[]};
while ~isempty(STACK)
    if N == 0
        break
    end
    X = STACK{end};
    STACK(end) = [];
    if length(X) < N
        if length(X) == 0
            X = 1;
            STACK{end + 1} = X;
        else
            Z = length(X) + 1;
            XN = [Z, X];
            STACK{end + 1} = XN;
            for i = 1:(Z-1)
                tempN = XN(i);
                tempSub = XN(i+1);
                XN(i) = tempSub;
                XN(i+1) = tempN;
                STACK{end+1} = XN;
            end
        end
    else
        if N == 0
            L = [];
        else
            count = count + 1;
            L(count, :) = X;
        end
    end
end

% Function End:
end

