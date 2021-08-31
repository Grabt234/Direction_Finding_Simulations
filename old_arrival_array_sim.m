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
spacing_x = [0 1 1.5 3] ;
spacing_y = [0 1 1.5 3] ;


%% GENERATING WAVEFORM



%% SIMULATING RECEIVAL

%angle of target 
theta = 3*pi/180;

%using phi = 2pi/lmbda * L * sin(theta)
phis = 2*pi/(lambda_use) * (spacing_x*(spacing_unit))* sin(theta)     
