
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
n = 1:1:2000;

%time
t = n*T;

t = repmat(t, length(pos_elements), 1);

%signal_generation being shifted to baseband
%additional term is phase noise

%%
sigs = sin((2*pi*(f_sig-f_mult))*t);

%sigs = [sigs zeros(length(pos_elements),1000)];

t = (1:1:length(sigs))*T;

%upscaling to each represent signal at each element
% sigs = repmat(sig, length(pos_elements), 1);
% 

%% APPLYING PHASE SHIFT FROM EACH ELEMENT

%simulating receival phase 
% ---- NORMALISED TO 2PI ----
differential_phases = gen_phase_offsets(pos_elements, foi, angle_of_arrival);

sigs = sigs.*exp(1i*2*pi*differential_phases.');

%% APPLYING NOISE TO WAVEFORMS FROM RECEIVAL AT EACH ELEMENT (note the S)

sigs = awgn(sigs, snr, "measured");

plot(1:1:length(sigs(1,:)),sigs(1,:))

%% PLOTTING WAVEFORM
%
SIGS = fft(sigs,[],2)./length(sigs);
SIGS = SIGS(:,length(SIGS)/2:end);

% plot(1:1:length(SIG),SIG)
% f_res = fs/length(n);
% f_axis = (1:1:length(SIGS))*f_res;
% 
% f_axis = f_axis + f_mult;
% 
% scaling = 1e9;
% f_axis = f_axis/scaling;
% 
% plot(f_axis, abs(SIGS(1,:)))
% xlabel("F (GHz)")

% plot(f_axis, abs(SIGS))

%% EXTRACTING MAX VALUE IN ARRAY AND TAKING PHASES

max_vals = max(SIGS,[],2);

%normalised anlges
max_vals_phase = angle(max_vals)/(2*pi);

%calculating differential - normalised
diff_phases = (max_vals_phase - max_vals_phase(1));

%% SELECTING PORTION OF ARRAY TO USE

AOA = aoa(foi,pos_elements, diff_phases)







