% This script prompts the user for how many times to flip a coin.
% Then, it counts number of times that Heads comes up.
N = input('Please enter the number of coin flips. ');
P = input('Please enter a probability between 0 and 1. ');
if P <=0 || >= 1
    print('error')
end
HEADS = 0;
for i = 1:N
    if rand < .5
        HEADS = HEADS + 1;
    end
end 
STATS = HEADS/N;
disp(STATS)
fprintf('The number of heads is %d. which occured %d. percent\n', HEADS, STATS)
