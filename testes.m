N = 2e3;                                % length
c = 299792458;                          % light speed
lambda = linspace(1e-6,2e-6,N);         % wavelength
t = linspace(0,10e-15,N);               % time
z = linspace(0,10e-6,N);                % distance
w = (2*pi*c)./lambda;                   % angular frequency
k0 = w/c;                               % wave number (free-space)

E0 = exp(1j*(w'*t));                    % complex electric field

%% Caminhos de reflexão e transmissão:
n1 = 1.32;                              % refractive index 1
n2 = 2.50;                              % refractive index 2
d1 = 10e-6;                             % distance 1
d2 = 10e-6;                             % distance 2

n = [n1 n2 n1 n2 n1];
d = [d1 d2 d1 0];

[S11,S21] = nmirror3(n,d,k0);

E1 = exp(1j*(d1*n1*k0'));              % phase 1
E2 = exp(1j*(d2*n2*k0'));              % phase 2
E = [E1 E2];                            % phase matrix
R = abs(n2-n1)/(n2+n1);                 % Reflection

S01 = nmirror(E,R,3);

%% Figuras
figure(1)
plot(lambda*1e6,abs(S11)); hold on;
plot(lambda*1e6,abs(S21));
plot(lambda*1e6,abs(S11).^2 + abs(S21).^2,'k');
ylabel('Amplitude (u.a.)')
xlabel('Wavelength (\mum)')
legend('|t|','|r|','|t|^2+|r|^2')
grid on;
%%
figure(2)
plot(lambda*1e6,abs(S11)); hold on;
plot(lambda*1e6,abs(S01));
ylabel('Amplitude (u.a.)')
xlabel('Wavelength (\mum)')
legend('TMM','SUM')
grid on;