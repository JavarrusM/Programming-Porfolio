function [count] = triangle6()
%PERMUTATIONS Generates all the arrangements of the true intergers
% 1, 2, 3, 4, 5, and 6.

count = 0;
for i1 = 1:6
    for i2 = 1:6
        if (i1 ~= i2)
            for i3 = 1:6
                if (i3 ~= i1) && (i3 ~= i2)
                    for i4 = 1:6
                        if (i4 ~= i1) && (i4 ~= i2) && (i4 ~= i3)
                            for i5 = 1:6
                                if (i5 ~= i1) && (i5 ~= i2) && (i5 ~= i3) && (i5 ~= i4)
                                    for i6 = 1:6
                                        if (i6 ~= i1) && (i6 ~= i2) && (i6 ~= i3) && (i6 ~= i4) && (i6 ~= i5)
                                            if ((i1 + i2) == (i3 + i4)) && ((i1 + i6) == (i3 + i4))
                                                count = count + 1;
                                                fprintf('    %d\n',i1)
                                                fprintf('  %d    %d   \n',i6,i2)
                                                fprintf('%d   %d   %d\n',i5,i4,i3)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end