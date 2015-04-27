close all

figure
subplot(211)
time = 0.001:0.001:2.5;

load pitchStep40deg

good = pitchStep40deg.signals.values(1:2500)-pitchStep40deg.signals.values(1);
load pitchStep40deg_bad
bad = (data(2,10001:12500) - data(2,10001))*pi/180;

plot(time,bad,'--b', time, good, 'b')

xlabel('Time [s]'); ylabel('Pitch angle [rad]');
legend('Original', 'Improved', 'Location', 'SouthEast');

subplot(212)
load elevWhilePitchStep40
good = data(3,10001:12500)-data(3,10001);

load elevWhilePitchStep40_bad
bad = data(3,10001:12500) - data(3,10001);

plot(time,bad,'--k', time, good, 'k')

xlabel('Time [s]'); ylabel('Elevation angle [rad]');
legend('Original', 'Improved', 'Location', 'NorthWest');

figure
time = 0.001:0.001:5;
%% Good model
Ac = [0    1    0    0;
      0    -0.03 -0.39   0;
      0    0    0    1;
      0    0  -7.13  -3.6];
Bc = [ 0 0 0 6.74]';

sys_good = ss(Ac,Bc,eye(4),[]);
step_good = step(sys_good,time)*pi*40/180;

%% Bad model

Acb = [0    1    0    0;
      0    0 -K_2   0;
      0    0    0    1;
      0    0  -K_1*K_pp  -K_1*K_pd];
Bcb = [ 0 0 0 K_1*K_pp]';

sys_bad = ss(Acb,Bcb,eye(4),[]);
step_bad = step(sys_bad,time)*pi*40/180;

%% Measured response
load pitchStep40deg
measured = pitchStep40deg.signals.values(1:5000)-pitchStep40deg.signals.values(1);

plot(time,step_bad(:,3),'-.b',time,step_good(:,3),'--b',time,measured,'k')
xlabel('Time [s]'); ylabel('Angle [rad]');
legend('Derived', 'Estimated', 'Measured', 'Location', 'SouthEast');
