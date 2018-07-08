N = input('Please give number of outcomes.');
for i = 1:N
    for j = (i+1):N
        %if i ~= j
            for k = (j+1):N
                %if (i ~= k) && (j ~= k)
                    fprintf('%d %d %d\n', i,j,k)
                %end
            end
        %end
    end
end
    
        