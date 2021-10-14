function [L] = perm52(a,b)
%PERM52 that enumerates and prints all the permutations of the integers
%       1, 2, 3, 4, and 5 such that a specified pair must be adjacent.
%       For example, if the integers 1 and 2 are specified to be adjacent,
%       then the permutations 12345, 35214, and 51243 satisfy the requirement,
%       but the permutations 13245, 54132, and 32451 do not satisfy the requirement.

count = 0;
for i1 = 1:5
    for i2 = 1:5
        if (i2 ~= i1)
            for i3 = 1:5
                if (i3~=i1) && (i3~=i2)
                    for i4 = 1:5
                        if (i4~=i1) && (i4~=i2) && (i4~=i3)
                            for i5 = 1:5
                                if (i5~=i1) && (i5~=i2) && (i5~=i3) && (i5~=i4)
                                    P = [i1,i2,i3,i4,i5];
                                    for i = 1:4
                                        if (P(i) == a && P(i+1) == b) ||...
                                                (P(i) == b && P(i+1) == a)
                                            count = count + 1;
                                            %disp(P)
                                            L(count,:) = P;
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
    % Function End
end

