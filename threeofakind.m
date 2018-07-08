function [count] = threeofakind()
%UNTITLED24 Summary of this function goes here
%   Detailed explanation goes here
count = 0;
for i1 = 1:6
    for i2 = 1:6
        for i3 = 1:6
            if (i3 == i1) && (i3 == i2)
                count = count + 1;
            else
                for i4 = 1:6
                    if (i4 == i1) && (i4 == i2) ||...
                            (i4 == i2) && (i4 == i3) ||...
                            (i4 == i1) && (i4 == i3)
                        count = count + 1;
                    else
                        for i5 = 1:6
                            if (i5 == i1) && (i5 == i2) ||...
                                    (i5 == i2) && (i5 == i3) ||...
                                    (i5 == i1) && (i5 == i3) ||...
                                    (i5 == i4) && (i5 == i1) ||...
                                    (i5 == i4) && (i5 == i2) ||...
                                    (i5 == i4) && (i5 == i3)
                                count = count + 1;
                                P = [i1,i2,i3,i4,i5];
                            end
                        end
                    end
                end
            end
        end
    end
end

end

