% Prompt the user to enter a probability strictly between 0 and 1.

% IF the user enters a value less than or equal to zero or greater than or
% equal to one, print an error message.

% Then, Set a counter equal to one.
% Generate a random number.
% While the random number is greater P,
%       increment the counter 
%       Generate another random number.
% end
% Display the number of trials (counter).

P = input('Please enter a probability between 0 and 1. ')
% Parameter Check
if P <= 0 || P >= 1
    error('This is not within the parameters')
end
% Count the number of trials
c = 1;
x = rand;
while (x > P)
   c = c + 1;
   x = rand;
end
fprintf('It took %d trials to be successful!\n', c)