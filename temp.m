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
%reference position
spacing_x = [0 0.0083 0.0125 0.025];
%spacing_y = [0 1 1.5 3] ;


%% DIFFERENTIAL ELEMENT PHASE

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
baseline_lf = spacing_x(4); %meters
 
%value
theta_lf = asin(p14*lambda_lf/(2*pi*baseline_lf));
%accuracy
theta_by_phi = lambda_lf/(2*pi*cos(3*pi/180));

%only display if checking LF
%disp(theta_lf*180/pi)
%disp(theta_by_phi)

%% IF CALC -> 12GHz, 2 ElEMENTS

%course baseline

%fine baseline

%course measure


%fine measure




















