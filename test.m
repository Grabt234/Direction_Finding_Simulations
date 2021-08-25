%% DEFINING ANTENNA

%operational frequency
f = 16e8;
c = 3e8;
lambda = c/f;

%define coeffecients wrt refernce antenna
spacing_unit = lambda/2;
% 4 elements in this antenna
% see E. Jeff Holder: (8.107)
spacing_x = [0 1 1.5 3] + 1;
spacing_y = [0 1 1.5 3] + 1;

%% UNWRAP PHASE AMBIGUITY

%calculation 
%for a 4 element array 

%start by solving a system of linear equations
%E.Jeff Holder 8.118

%phase differences need to calculated from array
p1 = 0.1;
p2 = 0.4;
p3 = 0.9;
p4 = 1.2;

p12 = p1 - p2;
p13 = p1 - p3;
p14 = p1 - p4;

%array element spacing
N1 = spacing_x(2);
N2 = spacing_x(3);
N3 = spacing_x(4);
%solving for k's
syms k2 k3 THETA

%assume k1 = 0
%%E.Jeff Holder 8.113 (below)
K1 = 0;

%setting up linear equations
%E.Jeff Holder 8.110
K2 = round(N2*K1/N1 - (N1*p13 - N2*p12)/(2*pi*N1))
K3 = round(N3*K1/N1 - (N1*p14 - N3*p12)/(2*pi*N1))

THETA = asin((p12+p13+p14)/((N1+N2+N3)*pi))
THETA_deg = THETA*180/pi

% [A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [k1, k2, k3]);
% Ks = (linsolve(A,B)).';

%solving for 
%E.Jeff Holder 8.11








