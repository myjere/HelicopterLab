%% LQR
Q = diag([4,2,0,0]);
R = 0.1;
K = dlqr(A,B,Q,R);

%% Prep reference trajectory
x_opt = x + repmat(xf, 1, length(x)); % Shift travel ref by pi
padded_x_opt = [zeros(4,floor(padding_time/dt)) , x_opt];
time = [(0:length(padded_x_opt) - 1)*dt];
heli_ref = [time; padded_x_opt]';