
%% SIMULATION PARAMTERS

aoa_deg = 10;
true_AOA = (aoa_deg)*(pi/180);

%frequency of interest
frequency = 6e9;

%linear array for x
pos_elements = [0 0.0083 0.0125 0.025]; %meters

simulations = 1000;

%storing snr, error
data = zeros(2,simulations);

false_alarm_count = 0;

%% MONTE-CARLO ! :) WHOHOO!

for sim_number = 1:simulations

    snr = 20*rand(1);

    %% GENERATING WAVEFORMS

    %signal parameters
    n = 5000; %constant for now
    f_samp = 50e6; %constant
    f_sig = 10e6; %constant

    signal = cw_gen(n,f_samp,f_sig);
    
    %used to determine a false alarm 
    I_known = find_true_index(signal);

    %% RECEIVING WAVEFORMS

    %conditioning signals with noise and phase 
    signals = condition_signal(signal, pos_elements, frequency, true_AOA, snr);

    %% TAKING FFT

    SIGS = half_fft(signals);

    %% FINDING WHERE SIGNAL IS PRESENT

    [element_phases, element_cmplx_voltages, frequency_indicies] = find_sigs(SIGS);

    %% EXTRACTING MAX VALUE IN ARRAY AND TAKING PHASES
     
    [false_alarms, indicies] = check_false_alarm(I_known, ...
                                        frequency_indicies);
    
    %adding number of false alarms to total_count
    false_alarm_count = false_alarm_count + false_alarms;

    %sdelecting the phase with true reading
    max_vals_phase = element_phases(:,indicies(1)).';

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

%normalised -> rad -> deg
data(2,:) =  (data(2,:)*2*pi)* 180/(2*pi);


RMSE = sqrt(mean((data(2,:)).^2))

%plotting results
scatter(data(1,:),data(2,:))
xlabel("SNR(dB)")
ylabel("Error (deg)")



