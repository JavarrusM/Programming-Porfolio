function [count] = subset()
%SUBSET
count = 0;
vector0 = zeros(1,5);
for i1 = 0:1
    %vector0(i1) = vector0(i1) + 1;
    for i2 = 0:1
        %vector0(i2) = vector0(i2) + 1;
        for i3 = 0:1
            %vector0(i3) = vector0(i3) + 1;
            for i4 = 0:1
                %vector0(i3) = vector0(i3) + 1;
                for i5 = 0:1
                    %vector0(i5) = vector0(i5) + 1;
                    count = 1 + count;
                    vector0 = [i1,i2,i3,i4,i5];
                    disp(vector0)
                end
            end
        end
    end
end
% Function End
end
