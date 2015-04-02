close all;

load data

wait = 10;

dt = 0.001;
p_c = data(4,floor(wait/dt):end);
p = data(6,floor(wait/dt):end);
travel_c = data(2,floor(wait/dt):end) - pi;
travel = data(7,floor(wait/dt):end) - data(7,floor(wait/dt)) - pi;
time = (0:length(p_c)-1)*dt;

figure
hold on
plot(time, p, 'b');
plot(time, travel, 'g');
plot(time, p_c, ':b');
plot(time, travel_c, ':g');
plot([0 time(end)],[0 0], ':k');
xlim([0 16]);
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('p', '\lambda','p_c','\lambda_c', '\lambda_f', 'Location', 'SouthEast');
hold off

figure
h = 0.25;
plot((0:length(heli_input)-wait/h)*h, heli_input(wait/h:end,2), 'r', time, p_c, ':r');
xlim([0 16]);
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('u^*', 'u', 'Location', 'SouthEast'); 