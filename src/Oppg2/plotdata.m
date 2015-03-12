

load data

wait = 10;

dt = data(1,2)-data(1,1);
p_c = data(2,floor(wait/dt):end);
p = data(3,floor(wait/dt):end);
travel = data(4,floor(wait/dt):end) - data(4,floor(wait/dt)) - pi;
time = (0:length(p_c)-1)*dt;


hold on
plot(time, p, ':b');
plot(time, p_c, ':r');
plot(time, travel, ':g');


hold off