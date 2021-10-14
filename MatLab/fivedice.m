function [count] = untitled20()
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here
count = 0;
for i1 = 1:6
    for i2 = 1:6
        % if (i1 ~= i2)
        for i3 = 1:6
            % if (i3 ~= i1) && (i3 ~= i2)
            for i4 = 1:6
                % if (i4 ~= i1) && (i4 ~= i2) && (i4 ~= i3)
                for i5 = 1:6
                    % if (i5 ~= i1) && (i5 ~= i2) && (i5 ~= i3) && (i5 ~= i4)
                    if (i1~=i2) && (i1~=i3) && (i1~=i4) && (i1~=i5) && ...
                            (i2~=i3) && (i2~=i4) && (i2~=i5) && ...
                            (i3~=i4) && (i3~=i5) && ...
                            (i4~=i5)
                        count = count + 1;
                        P = [i1,i2,i3,i4,i5];
                    end
                end
            end
        end
    end
end
end

