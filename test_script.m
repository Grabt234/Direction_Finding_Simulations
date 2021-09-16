%% SIMULATION PARAMTERS

aoa_azim = -30;
aoa_elev = 30;
%to radian
true_AOA = (aoa_azim)*(pi/180);

%linear array spacing
pos_elements = [0 0.0083 0.0125 0.025]; %meters

simulations = 3999;

%storing snr, error
data = zeros(2,simulations);

false_alarm_count = 0;


%% MONTE-CARLO ! :) WOOHOO!
snr = 1;
for sim_number =1:simulations

    %snr = 20*rand(1);

    %% GENERATING WAVEFORMS

    if mod(sim_number,200) == 0
        snr = snr + 1;
    end

    %signal parameters
    n = 16000; %constant for now
    f_samp = 4e9; %constant
    f_sig = 0.5e9; %constant
    f_lo = 17.5e9;
    f_rf = f_sig+f_lo;
    duty = 0.1; %1 percent
    threshold_factor = 5;
    
    %signal = cw_gen(n,f_samp,f_sig);
    signal = pulse_gen(n,duty).*sin((1:1:n)*2*pi*f_sig*(1/f_samp));
    %signal = chirp_gen(n,f_samp,500e6,250e6, 0.00001);
 
    %used to determine a false alarm 
    I_known = find_true_index(signal);
    
    %% MULTI SIG CASE
    
%     snr = 20*rand(1);
%     
%     n = 16000;
%     
%     f_samp = 4e9;
%     
%     duty = 0.1;
%     
%     f_lo = 6.25e9;
%     
%     signal_1 = pulse_gen(n,duty);
%     signal_2 = pulse_gen(n,duty);
%     
%     f1 = 150e6;
%     f2 = 750e6;
%     
%     %shifting to desired frequency
%     signal_1 = signal_1.*sin(2*pi*f1*(1/f_samp)*(1:1:n));
%     signal_2 = signal_2.*sin(2*pi*f2*(1/f_samp)*(1:1:n));
%     
%     I_known_1 = find_true_index(signal_1);
%     I_known_2 = find_true_index(signal_2);
%     I_known = [I_known_1 I_known_2];
%     
%     signal_3 = signal_1 + signal_2;
%     
%     SIGNAL_3 = fftshift(fft(signal_3));
%     %SIGNAL_3 = awgn(SIGNAL_3, , "measured");
%     
%     
%     signal = signal_3;
    
    
    
    %% RECEIVING WAVEFORMS
    
    %conditioning signals with noise and phase 
    signals = condition_signal(signal, pos_elements, f_rf, true_AOA, snr);
    
    samples = n;
    %to see time domain plot
%     SIGNAL = fftshift(fft(signal)./length(signal));
%     ax = (-(samples-1)/2:1:(samples-1)/2)*(f_samp/samples);
%     plot(ax,abs(SIGNAL))
%     figure
%     
    %% TAKING FFT

    [SIGS, ~] = half_fft(signals);
    
    %a lovely plot of a one sided frequency domain
    
    %% FINDING WHERE SIGNAL IS PRESENT
    
    %element phases are normalised 
    [element_phases, element_cmplx_voltages, frequency_indicies] = find_sigs(SIGS,threshold_factor);
    
    %created to keep track of original index-frequency relationship
    orig_freq_indicies = frequency_indicies;
    
    %% TAKING MIDPOINT OF CONTINUOUS THRESHOLDS
    
    %1 means two indicies are continuous [1,2,3,4]
    %0 means not [1,2,3,4,21,22,23]
    %used to find presence of multiple signals
    continuous_bools = (diff(frequency_indicies)==1);
    
    %indicies of idicies of where continuity breaks - ie seperations
    %between signals
    [~, continuous_indicies] = find(continuous_bools == 0);
    
    removed_count = 0;
    index_of_frequency = zeros(0,0);
   
    %cutting into arrs of continuous indicies
    for i = 1:numel(continuous_indicies)
    
        %cutting continuous set of signal indicies out
        continuous_sig_indicies = frequency_indicies(1, ...
                                   1:continuous_indicies(i)-removed_count);
   
        removed_elements = length(continuous_sig_indicies);
        
        index_of_frequency = [index_of_frequency ...
                                    continuous_sig_indicies(:,ceil( end/2))];
        
        %counting how many indicies were removed
        removed_count = removed_count + removed_elements ;
        
        %removing counted set of indicies
        frequency_indicies = frequency_indicies(1, removed_elements +1:end);
        
      
    end
    
    continuous_sig_indicies = frequency_indicies(1, ...
                                 1:end);
                             
    if length(continuous_sig_indicies ) ~= 0
        
        index_of_frequency = [index_of_frequency ...
                        continuous_sig_indicies(:,ceil( end/2))];
                    
    end
    
    %at this point have selected all actual frequency values
    frequency_indicies = index_of_frequency;
    %complicated as a by product of previous code
    %the fft take the max index as 0hz reference
    frequencies = (length(SIGS) - frequency_indicies +1)*(f_samp/n) + f_lo;
    
    %% FINDING FALSE ALARMS:
    
    true_indicies = index_of_frequency;
    
    % -- removed due to time constraints --
 
%     %known issue with roll off causing multiple detection for a single peak
%     %returns indicies of actual signals
%     [false_alarms, true_indicies] = check_false_alarm(I_known, ...
%                                         frequency_indicies)
%     
%     %adding number of false alarms to total_count
%     false_alarm_count = false_alarm_count + false_alarms;

    %% CALCULATING ELEMENT PHASES
    
    %selecting row of phase values corresponsing to set of antenna elements
    
    original_freq_phase_index =  find(orig_freq_indicies == 6002)
    single_elements_phases = element_phases(:,original_freq_phase_index ).';

    %calculating differential wrt to first element - normalised
    diff_phases = (single_elements_phases - single_elements_phases(1));

    %% CALCULATING RECIEVER DETERMINED AOA
    
    foi = 18e9;
    
    %max frequency is defined by the demodulation process
    calculated_AOA = aoa(foi,pos_elements, diff_phases);
   

    %% CALCULATING ERROR
    
    %rad
    error = true_AOA - calculated_AOA;

    %% STORING STATE INFORMATION
    
    data(1,sim_number) = snr;
    %in radians
    data(2,sim_number) = error;
    data(3,sim_number) = calculated_AOA;
    data(4,sim_number) = true_AOA;


end

%rad
data(2,:) =  (data(2,:))*180/pi;


RMSE = sqrt(mean((data(2,:)).^2))


%plotting results
scatter(data(1,:),data(2,:))
xlabel("SNR(dB)")
ylabel("Error (deg)")

