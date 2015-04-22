close all;

load closedLoop

wait = 10;

h = data(1,2)-data(1,1);
travel = data(2,floor(wait/h):end) - data(2,floor(wait/h)) - pi;
pitch = data(3,floor(wait/h):end);
time = (0:length(pitch)-1)*h;
time_ = (0:N)*dt;

hold on
plot(time_, pitch_opt, 'O:b');
plot(time_, travel_opt, 'O:g');
plot(time, pitch, 'b');
plot(time, travel, 'g');
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('p^*', '\lambda^*', 'p', '\lambda', 'Location', 'SouthEast');
xlim([0 12.8]);

hold off