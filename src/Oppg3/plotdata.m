

load data

wait = 10;

dt = 0.001;
p_c = data(4,floor(wait/dt):end);
p = data(6,floor(wait/dt):end);
travel_c = data(2,floor(wait/dt):end) - pi;
travel = data(7,floor(wait/dt):end) - data(7,floor(wait/dt)) - pi;
time = (0:length(p_c)-1)*dt;


hold on
plot(time, p, 'b');
plot(time, p_c, ':b');
plot(time, travel, 'g');
plot(time, travel_c, ':g');
plot([0 time(end)],[0 0], ':r');
xlim([0 16])


hold off