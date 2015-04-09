Q = diag([2,1,0,0,2,1]);
R = diag([1 1]);

x_opt = x + repmat(xf, 1, length(x)); % Shift travel ref by pi

padding_time = 10;
padded_x_opt = [zeros(6,floor(padding_time/dt)) , x_opt];
time = (0:length(padded_x_opt) - 1)*dt;
heli_ref = [time; padded_x_opt]';

K = dlqr(A,B,Q,R);
K = zeros(2,6);