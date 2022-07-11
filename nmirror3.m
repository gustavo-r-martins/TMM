function [T,R] = nmirror3(n,d,k)
    arguments
        n   % refractive index
        d   % layers distance
        k   % wave number
    end
    % [T,R] = nmirror(n,d,k)
    % where n is the refractive index, d is the layer distance, k is the
    % wave number. T and R are the transmission and reflection
    % coefficients.
    % The distance vector must have an extra component, d(end) = 0.
    %
    % For M dielectric mirrors, with M = 4, we have:
    %       |       |       |       |
    %   n0  |   n1  |   n2  |   n3  |   n4
    %       |   d1  |   d2  |   d3  |  d4=0
    %       |       |       |       |
    %
    % |T|^2 + |R|^2 = 1 if n(1) = n(end), otherwise, the determinant of the
    % transfer matrix isn't +1.

    K = length(k);                          
    M = length(n)-1;                        % number of 'mirrors'

    T = zeros(K,1);
    R = zeros(K,1);
    
    for i = 1:K
        S = eye(2,2);
        for m = 1:M
            n1 = n(m);                      % refractive index 1 (left)
            n2 = n(m+1);                    % refractive index 2 (rigth)
            r = (n1-n2)/(n1+n2);            % reflectance
            t = 1+r;                        % transmitance    

            D = (1/t)*[1 r; r 1];           % interface matrix
            E = exp(-1j*n2*k(i)*d(m));
            P = [conj(E) 0; 0 E];           % propagation matrix
            S = S*D*P;
        end
        T(i) = 1/S(1,1);                    % transmission coefficient
        R(i) = S(2,1)/S(1,1);               % reflection coefficient
    end
end