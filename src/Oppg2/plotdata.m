close all; clc;

load data

wait = 10;

h = data(1,2)-data(1,1);
p_c = data(2,floor(wait/h):end);
p = data(3,floor(wait/h):end);
la = data(4,floor(wait/h):end) - data(4,floor(wait/h)) - pi;
time = (0:length(p_c)-1)*h;
time_ = (0:N)*dt;

hold on
plot(time_, u, 'r');
plot(time_, pitch, 'b');
plot(time_, travel, 'g');
plot(time, p_c, ':r');
plot(time, p, ':b');
plot(time, la, ':g');
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('u^*', 'p^*', '\lambda^*', 'u', 'p', '\lambda', 'Location', 'SouthEast');
xlim([0 12.8]);

hold off