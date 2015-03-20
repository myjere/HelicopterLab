clear all
close all
init02
clc

%% Continous model
Ac = [0    1    0    0   0   0;
      0  -0.03 -0.39 0   0   0;
      0    0    0    1   0   0;
      0    0 -7.13 -3.6  0   0;
      ;
      ];
Bc = [ 0 0 0 6.74  0  0]';

%% Discrete model
dt = 0.25;
A = eye(4) + Ac*dt;
B = Bc*dt;

% given: x0 = [0 0 0 0]';
xf = [pi 0 0 0]';

n_x = size(A,2);
n_u = size(B,2);

%%
duration = 25;
N = floor(duration/dt);
q = .1;
pitch_lim = 45; % deg

%% Equality constraints

Aeq = [ eye(N*n_x) + kron(diag(ones(N-1,1),-1), -A) , kron(eye(N), -B)];

beq = [-A*xf;
       zeros(n_x*(N-1),1)];