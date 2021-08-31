%% DEFINING ANTENNA

c = 3e8;

%operational frequency
f_lf = 6e8;
f_if = 12e8;
f_hf = 18e8;

%wavelengths operating at various frequencies
lambda_lf = c/f_lf;
lambda_if = c/f_if ;
lambda_hf = c/f_hf;

%define coeffecients wrt refernce antenna
%unit defined in terms of smallest wavelength
spacing_unit = lambda_hf/2;

% 4 elements in this antenna
% see E. Jeff Holder: (8.107)
%lengths wrt to pos(1) tf pos(1) = 0
spacing_x = [0 1 1.5 3];
spacing_y = [0 1 1.5 3] + 1;

%% ELEMENT PHASES

%start by solving a system of linear equations
%E.Jeff Holder 8.118

%phase at antenna elements
% p1 = 0.1644;
% p2 = 0.3288;
% p3 = 0.4110;
% p4 = 0.6577;

p1 = 0.0;    
p2 = 0.1096;  
p3 = 0.1664;  
p4 = 0.3288;

%differential phase differences need to calculated from array
p12 = p1 - p2;
p13 = p1 - p3;
%phase difference for largest baseline
p14 = p1 - p4;

%% LF CALC -> 6GHZ, 2 ELEMENTS

%max lambda size, therefore one baseline (no course and fine measure)
baseline_lf = (spacing_x(4))*spacing_unit;

%value
theta_lf = asin(p14*lambda_lf/(2*pi*baseline_lf));
%accuracy
theta_by_phi = lambda_lf/(2*pi*cos(3*pi/180));

%onyl display if checking LF
% disp(theta_lf*180/pi)
% disp(theta_by_phi)

%% IF CALC -> 12GHZ, 3 ELEMENTS

%p12 meets spacial nyquist tf p12 = pi * sin(theta)
%consider p13 and a multipl N of length between p1, p2

%see E. Jeff Holder: (8.94 - 8.97)
%Np12 = N * pi * sin(theta) = 2K*pi + phi_residual 
%ph_residual appears to be phase we are solving for
%we have two equations above. solve for K then for theta

%now defining IF fine baseline
baseline_fine_if = spacing_x(4)*spacing_unit
N=2;
%from E. Jeff Holder: (8.96)
K = (N*p12 - p13)/(2*pi)
theta_if = asin( (p13 + 2*K*pi)/(pi*N) )*180/pi





