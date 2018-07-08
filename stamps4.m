function v = stamps4(S,P)
S(end+1) = 0;
for i1 = S
    for i2 = S
        for i3 = S
            for i4 = S
                if sum([i1, i2, i3, i4]) == P
                    v = [i1, i2, i3, i4];
                    return % quits the program after finding solution 
                end
            end
        end
    end
end
disp('No Solution')
v = [];
end