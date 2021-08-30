
%% SIMULATING PHASE RECEIVAL
snr = 0;
aoa_deg = 30
%frequency of interest
foi = 18e9;


%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters

angle_of_arrival = (aoa_deg)*(pi/180)

%aoa = pi/16;   


%% GENERATING WAVEFORMS


f_sig = 6e9;
f_mult = 5.99e9;

bw = 100; % in MHz

%sampling rate
fs = (bw*2)*1e6;
%sampling preiod
T = 1/fs;
%samples
n = 1:1:5000;

%time
t = n*T;



%signal_generation being shifted to baseband
%additional term is phase noise

%%
sig = sin((2*pi*(f_sig-f_mult))*t);

%sigs = [sigs zeros(length(pos_elements),1000)];

t = (1:1:length(sigs))*T;

sigs = condition_signal(sig, pos_elements, frequency, true_aoa, snr);


%% TAKING FFT
%
SIGS = half_fft(sigs);

%% FINDING WHERE SIGNAL IS PRESENT

[element_phases, element_cmplx_voltages, frequency_indicies] = find_sigs(SIGS);

%% EXTRACTING MAX VALUE IN ARRAY AND TAKING PHASES

%for now sleecting first phase only
max_vals_phase = element_phases(:,1).';

%calculating differential - normalised
diff_phases = (max_vals_phase - max_vals_phase(1));

%% SELECTING PORTION OF ARRAY TO USE

AOA = aoa(foi,pos_elements, diff_phases);







