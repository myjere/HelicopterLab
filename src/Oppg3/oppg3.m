n_x = 4;

Q = diag([4,2,0,0]);
R = 0.1;

x_opt = x + repmat(xf, 1, length(x)); % Shift travel ref by pi
travel_opt = [-xf(1), x(1,:)];
pitch_opt = [-xf(3), x(3,:)];

padding_time = 10;
padded_x_opt = [zeros(4,floor(padding_time/dt)) , x_opt];
time = [(0:length(padded_x_opt) - 1)*dt];
heli_ref = [time; padded_x_opt]';

K = dlqr(A,B,Q,R);
