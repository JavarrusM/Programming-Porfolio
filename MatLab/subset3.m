function [count] = subset3(S)
%SUBSET3
count = 0;
%for i1 = 1:3
for i1 = 1:S
    %for i2 = 2:4
    for i2 = (i1+1):S
        %if (i1<i2)
            for i3 = (i2+1):S
                %if (i2<i3) && (i1<i3)
                    P = [i1,i2,i3];
                    count = 1 + count;
                    disp(P)
                %end
            end
        %end
    end
end
% Function End
end
