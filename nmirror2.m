function [T,R] = nmirror2(n,d,k)
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
    % |T|^2 + |R|^2 = +1. Using a normalized transfer matrix.

    K = length(k);                          
    M = length(n)-1;                        % number of 'mirrors'

    T = zeros(K,1);
    R = zeros(K,1);
    
    for i = 1:K
        S = eye(2,2);
        for m = 1:M
            n0 = n(1);                      % refractive index 0 (reference)
            ni = n(m+1);                    % refractive index i (i-th layer)

            r = (n0-ni)/(n0+ni);            % reflectance
            t = 1+r;                        % transmitance    
            D0i = (1/t)*[1 r; r 1];         % interface matrix

            E = exp(-1j*ni*k(i)*d(m));
            P = [conj(E) 0; 0 E];           % propagation matrix
            
            r = (ni-n0)/(ni+n0);            % reflectance
            t = 1+r;                        % transmitance    
            Di0 = (1/t)*[1 r; r 1];         % interface matrix

            S = S*D0i*P*Di0;
        end
        T(i) = 1/S(1,1);                    % transmission coefficient
        R(i) = S(2,1)/S(1,1);               % reflection coefficient
    end
end