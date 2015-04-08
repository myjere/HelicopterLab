close all;

load data

wait = 10;

h = 0.001;
p_c = data(2,floor(wait/dt):end);
e_c = data(3,floor(wait/dt):end);
p = data(4,floor(wait/dt):end);
travel = data(5,floor(wait/dt):end) - pi;
elev = data(6,floor(wait/dt):end);
time = (0:length(p_c)-1)*h;

figure
hold on
plot(time, p, 'b');
plot(time, travel, 'g');
plot(time, elev, 'k');
plot(time, p_c, ':b');
plot(time, e_c, ':k');
%plot([0 time(end)],[0 0], ':k');
xlim([10 16]);
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('p', '\lambda','e','p_c', 'e_c', 'Location', 'NorthWest');
hold off

% figure
% plot((0:length(heli_input)-wait/h)*dt, heli_input(wait/h:end,2), 'r', time, p_c, ':r');
% xlim([0 16]);
% xlabel('Time [s]'); ylabel('Angle [rad]');
% legend('u^*', 'u', 'Location', 'SouthEast'); 