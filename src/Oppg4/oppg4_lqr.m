Q = diag([10,1,3,1, 5, 2]);
R = diag([5 10]);

x_opt = x + repmat(xf, 1, length(x)); % Shift travel ref by pi

padding_time = 10;
padded_x_opt = [zeros(6,floor(padding_time/dt)) , x_opt];
time = (0:length(padded_x_opt) - 1)*dt;
heli_ref = [time; padded_x_opt]';

K = dlqr(A,B,Q,R);
