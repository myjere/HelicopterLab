
clear all
close all
init02
clc

% Continous model
Ac = [0    1    0    0;
      0    0 -0.23   0;
      0    0    0    1;
      0    0  -16  -7.2];
Bc = [ 0 0 0 15.6]';

% Discrete model
dt = 0.001;
A = eye(4) + Ac*dt;
B = Bc*dt;

