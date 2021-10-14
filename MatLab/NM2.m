function [X, Z] = NM2(f,P,Q,R,t)
%NM2

    function [B,G,W] = Label(P1,P2,P3)
        [V1, I] = sort([feval(f, P1), feval(f, P2), feval(f, P3)]);
        V2 = {P1, P2, P3};
        B = V2{I(1)}; G = V2{I(2)}; W = V2{I(3)};
        % Function End:
    end

% Initalizing:
[B,G,W] = Label(P, Q, R);
L = LongestL(B,G,W);
format Long

% Body:
while t < L
    % 0 Fill
    x = [B(1), W(1), G(1)];
    y = [B(2), W(2), G(2)];
    fill(x, y, rand(1,3))
    hold on
    
    % 1 Midpoint:
    M = (B+G)/2;
    
    % 2 Reflection:
    R = 2*M - W;
    
    % 3 Expansion:
    if feval(f, R) < feval(f, B)
        E = 2*R - M;
        if feval(f, E) < feval(f, R)
            % Accept E
            [B,G,W] = Label(E, G, B);
            disp("Expansion")
        else
            % Accept R
            [B,G,W] = Label(R, G, B);
            disp("Expansion")
        end
        
        % 4 Acceptance:
    elseif feval(f, B) <= feval(f, R) && feval(f, R) < feval(f, G)
        % Accept R
        [B, G, W] = Label(R, G, B);
        %disp("Acceptance")
        
        % 5 Outside Contraction:
    elseif feval(f, G) <= feval(f, R) && feval(f, R) < feval(f, W)
        C =(M + R) / 2; % Outside Contraction Point
        if feval(f, C) <= feval(f, R)
            [B, G, W] = Label(C, B, G);
            %disp("Outside Contraction")
        else
            S = (W+B)/2;
            [B G W] = Label(S, M, B);
            %disp("Outside Contraction")
        end
        
        % 6 Inside Contraction:
    elseif feval(f, W) <= feval(f, R)
        CC = (W+M)/2;
        if feval(f, CC) < feval(f, W)
            [B G W] = Label(CC, G, B);
            %disp("Inside Contraction")
        else
            S = (W+B)/2;
            [B G W] = Label(S, M, B);
            %disp("Inside Contraction")
        end
    end
    X = B;
    Z = feval(f, B);
    L = LongestL(B,G,W);
end
hold off
% Function End:
end

function [X] = LongestL(P1, P2, P3)
S1 = sqrt((P1(1)- P2(1))^2 + (P1(2) - P2(2))^2);
S2 = sqrt((P2(1)- P3(1))^2 + (P2(2) - P3(2))^2);
S3 = sqrt((P1(1)- P3(1))^2 + (P1(2) - P3(2))^2);
V1 = sort([S1, S2, S3]);
X = V1(3);
% Function End:
end


