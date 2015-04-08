close all;

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

%plot([0 time(end)],[0 0], ':k');
xlim([0 12]);
xlabel('Time [s]'); ylabel('Angle [rad]');
%legend('p', '\lambda','e','p_c', 'e_c', 'Location', 'NorthWest');
hold off

% figure
% plot((0:length(heli_input)-wait/h)*dt, heli_input(wait/h:end,2), 'r', time, p_c, ':r');
% xlim([0 16]);
% xlabel('Time [s]'); ylabel('Angle [rad]');
% legend('u^*', 'u', 'Location', 'SouthEast'); 