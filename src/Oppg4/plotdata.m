close all;

%load openLoop25
%load openLoop45
%load closedLoop25
%load closedLoopConstrained25
load data

wait = 10;

h = 0.001;
travel = data(2,floor(wait/h):end) - data(2,floor(wait/h)) - pi;
pitch = data(3,floor(wait/h):end);
elevation = data(4,floor(wait/h):end);
time = (0:length(travel)-1)*h;

time_opt = (0:length(pitch_opt)-1)*dt;


figure
hold on
plot(time, pitch, 'b');
plot(time, travel, 'g');
plot(time, elevation, 'k');
plot(time_opt, pitch_opt, 'O:b');
plot(time_opt, travel_opt, 'O:g');
plot(time_opt, elevation_opt, 'O:k');

xlim([0 12]);
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('p', '\lambda','e','p^*', '\lambda^*', 'e^*', 'Location', 'SouthEast');
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


