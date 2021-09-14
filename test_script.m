
%% SIMULATION PARAMTERS

aoa_deg = -10;
true_AOA = (aoa_deg)*(pi/180);

%frequency of interest
frequency = 18e9;

%linear array spacing
pos_elements = [0 0.0083 0.0125 0.025]; %meters

simulations = 1000;

%storing snr, error
data = zeros(2,simulations);

false_alarm_count = 0;

duty = 0.1;

%% MONTE-CARLO ! :) WHOHOO!

for sim_number =1:simulations

    snr = 20*rand(1);

    %% GENERATING WAVEFORMS

    %signal parameters
    n = 5000; %constant for now
    f_samp = 10e6; %constant
    f_sig = 1e6; %constant

    %signal = cw_gen(n,f_samp,f_sig);
    %signal = pulse_gen(n,duty);
    %signal = chirp_gen(n,f_samp,f_sig,f_sig/2, 1000);

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
    
    %returns indicies of actual signals
    [false_alarms, true_indicies] = check_false_alarm(I_known, ...
                                        frequency_indicies);
    
    %adding number of false alarms to total_count
    false_alarm_count = false_alarm_count + false_alarms;

    %selecting row of phase values corresponsing to set of antenna elements
    single_elements_phases = element_phases(:,true_indicies(1)).';

    %calculating differential wrt to first element - normalised
    diff_phases = (single_elements_phases - single_elements_phases(1));

    %% CALCULATING RECIEVER DETERMINED AOA

    calculated_AOA = aoa(frequency,pos_elements, diff_phases);

    %% CALCULATING ERROR

    error = true_AOA - calculated_AOA;

    %% STORING STATE INFORMATION

    data(1,sim_number) = snr;
    data(2,sim_number) = error;
    data(3,sim_number) = calculated_AOA;
    data(4,sim_number) = true_AOA;
    
    calculated_AOA;
    true_AOA;

end

%normalised -> rad -> deg
data(2,:) =  (data(2,:)*2*pi)* 180/(2*pi);


RMSE = sqrt(mean((data(2,:)).^2));

%plotting results
scatter(data(1,:),data(2,:))
xlabel("SNR(dB)")
ylabel("Error (deg)")



