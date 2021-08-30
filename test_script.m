
%% SIMULATION PARAMTERS

aoa_deg = 30;
true_AOA = (aoa_deg)*(pi/180);

%frequency of interest
frequency = 18e9;

%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters

simulations = 1;

%storing snr, error
data = zeros(2,simulations);

%% MONTE-CARLO ! :) WHOHOO!

for sim_number = 1:simulations

    snr = 20*rand(1);

    %% GENERATING WAVEFORMS

    %signal parameters
    n = 5000; %constant for now
    f_samp = 50e6; %constant
    f_sig = 10e6; %constant

    signal = cw_gen(n,f_samp,f_sig);

    %% RECEIVING WAVEFORMS

    %conditioning signals with noise and phase 
    signals = condition_signal(signal, pos_elements, frequency, true_AOA, snr);

    %% TAKING FFT

    SIGS = half_fft(signals);

    %% FINDING WHERE SIGNAL IS PRESENT

    [element_phases, element_cmplx_voltages, frequency_indicies] = find_sigs(SIGS);

    %% EXTRACTING MAX VALUE IN ARRAY AND TAKING PHASES

    %for now sleecting first phase only
    max_vals_phase = element_phases(:,1).';

    %calculating differential - normalised
    diff_phases = (max_vals_phase - max_vals_phase(1));

    %% CALCULATING RECIEVER DETERMINED AOA

    calculated_AOA = aoa(foi,pos_elements, diff_phases);

    %% CALCULATING ERROR

    error = true_AOA - calculated_AOA;

    %% STORING STATE INFORMATION

    data(1,sim_number) = snr;
    data(2,sim_number) = error;

end





