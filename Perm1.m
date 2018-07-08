function [count] = Perm1()
%PERMUTATIONS Generates all the arrangements of the true intergers
% 1, 2, 3, 4, 5, and 6.

count = 0;
for i1 = 1
    for i2 = 2:5
        for i3 = 2:5
            if (i3 ~= i2)
                for i4 = 2:5
                    if (i4 ~= i2) && (i4 ~= i3)
                        for i5 = 2:5
                            if (i5 ~= i2) && (i5 ~= i3) && (i5 ~= i4)
                                count = count + 1;
                                fprintf('%d%d%d%d%d \n',i1,i2,i3,i4,i5)
                            end
                        end
                    end
                end
            end
        end
    end  
end
end