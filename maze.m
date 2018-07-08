function X = maze(A)
% MAZE: The purpose of this function is to write the user-defined MATLAB function maze.m
%   that finds the path through an N-by-N maze, if such a path exists. Each square in
%   the maze has been assigned an integer beginning with 1 and ending with
%   N2. The start of the maze will always be Square 1, and the end will always be Square N2. 

% Initialize:
STACK{1} = 1;
N = length(A);
VISITED = zeros(1,N); VISITED(1) = 0; % Preset 1 Visit

% Body:
while ~isempty(STACK)
    PATH = STACK{end};
    STACK(end) = [];
    if PATH(end) == N
        X = PATH;
        return
    else
        LAST = PATH(end);
        P = A{LAST};
        for i = P
            if VISITED(i) == 0
                VISITED(i) = 1;
                STACK{end+1} = [PATH, i];
            end
        end
    end 
% While End:    
end
X = [];
disp('There is no path through this maze.')
% Function End:
end
