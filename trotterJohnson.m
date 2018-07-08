function [ L ] = trotterJohnson( N )
%TROTTERJOHNSON takes a poseive integer N input and uses a minimal-change
% ordering to construct a list L, which will be a mtrix, of all permutations
% of the values 1,2,3,...,N

% Initial:
if N == 0
    L = [];
elseif N == 1
    L = 1;
else
    % Setup:
    QUEUE{1} = [1, 2]; % Initialize QUEUE
    QUEUE{2} = [2, 1]; % Initialize QUEUE
    L = zeros(factorial(N), N); % Relallocate L
    count = 1;
    % Body:
    while ~isempty(QUEUE)
        % Form Z and Enqueue X and Y
        Z = length(X);
        X = QUEUE{1};
        QUEUE(1) = [];
        Y = QUEUE{1};
        QUEUE(1) = [];
        if length(X) == N
            % Load L
            L(count,:) = X;
            count = count + 1;
            L(count,:) = Y;
            count = count + 1;
        else            
            % Form, Perm, Enqueue New X:
            XN = [X, Z];
            QUEUE{end + 1} = XN;
            for i = Z:-1:2
                tempN = XN(i);
                tempSub = XN(i-1);
                XN(i) = tempSub;
                XN(i-1) = tempN;
                QUEUE{end+1} = XN;
            end
            % Form, Perm, Enqueue New Y:
            YN = [Z, Y];
            QUEUE{end + 1} = YN;
            for i = 1:(Z-1)
                tempN = YN(i);
                tempSub = YN(i+1);
                YN(i) = tempSub;
                YN(i+1) = tempN;
                QUEUE{end+1} = YN;
            end            
        end
    end
end

% Function End
end

