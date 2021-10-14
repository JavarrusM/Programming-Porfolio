function [BEST_PATH, BEST_DIST] = TSP6(M)
% TSP6(M) calculates the solution to the Traveling Salesman
% Problem for six cities by generating all permutations,
% beginning with City 1.
% Input   = M, the adjancy matric
% Outputs = BEST_PATH, the vector containing the best path
%           Best_DIST, the distance traveled

BEST_PATH = zeros(1,7);
BEST_DIST = inf;
for i2 = 2:6
    for i3 = 2:6
        if (i3 ~= i2)
            for i4 = 2:6
                if (i4 ~= i2) && (i4 ~= i3)
                    for i5 = 2:6
                        if (i5 ~= i2) && (i5 ~= i3) && (i5 ~= i4)
                            for i6 = 2:6
                                if (i6 ~= i2) && (i6 ~= i3) && (i6 ~= i4) && (i6 ~= i5)
                                    P = [1, i2, i3, i4, i5, i6, 1]; % Next Path
                                    %D = M(P(1),P(2)) + M(P(2),P(3)) + M(P(3),P(4)) +...
                                    %    M(P(4),P(5)) + M(P(5),P(6));
                                    D = 0; % Distance of Next Path
                                    for j = 1:6
                                        D = D + M(P(j),P(j+1));
                                    end
                                    if (D < BEST_DIST)
                                        % Update BEST_PATH and BEST_DIST
                                        BEST_PATH = P;
                                        BEST_DIST = D;
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