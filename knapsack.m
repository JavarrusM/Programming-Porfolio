function [maxw,maxp] = knapsack(w,p,cap)
%UNTITLED35 Summary of this function goes here
%   Detailed explanation goes here

%check
if length(w) ~= length(p)
    error('Invalid inputs')
end

% Setup
maxp = 0;

for i1 = 0:1
    for i2 = 0:1
        for i3 = 0:1
            for i4 = 0:1
                for i5 = 0:1
                    bivector = [i1,i2,i3,i4,i5];
                    weight = sum(w.*bivector);
                    profit = sum(p.*bivector);
                    if weight <= cap
                        if profit > maxp
                            maxp = profit;
                            maxw = weight;
                        end
                    end
                end
            end
        end
    end
end


% Function End
end

