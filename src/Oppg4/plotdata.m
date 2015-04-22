close all;

load data

wait = 10;

h = data(1,2)-data(1,1);
travel = data(2,floor(wait/h):end) - data(2,floor(wait/h)) - pi;
pitch = data(3,floor(wait/h):end);
elevation = data(4,floor(wait/h):end);
time = (0:length(travel)-1)*h;
time_ = (0:N)*dt;

figure
hold on
plot(time, pitch, 'b');
plot(time, travel, 'g');
plot(time, elevation, 'k');
plot(time_, pitch_opt, 'O:b');
plot(time_, travel_opt, 'O:g');
plot(time_, elevation_opt, 'O:k');
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('p', '\lambda','e','p^*', '\lambda^*', 'e^*', 'Location', 'SouthEast');
xlim([0 12]);
hold off

con = 0.2*exp(-20*(travel + 2*pi/3).^2);

figure
hold on
plot(travel, con, 'r');
plot(travel, elevation, 'k');
plot(travel_opt, elevation_opt, 'O:k');
xlabel('Travel [rad]'); ylabel('Elevation [rad]');
legend('c', 'e', 'e^*');
xlim([-pi 0.1]);
hold off