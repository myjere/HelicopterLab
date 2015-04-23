close all

load elevWhilePitchStep40
good = data(3,10001:15000)-data(3,10001);

load elevWhilePitchStep40_bad
bad = data(3,10001:15000) - data(3,10001);

time = 0.001:0.001:5;

plot(time,good,'b', time, bad, 'r')
