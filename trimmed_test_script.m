%% SIMULATION PARAMTERS

aoa_azim_0 = 30;
aoa_elev_0 = -30;
%to radian

true_aoa_azim_0 =  aoa_azim_0*(pi/180);
true_aoa_elev_0 = aoa_elev_0*(pi/180);

%%

aoa_azim_1 = 30;
aoa_elev_1 = -40;

aoa_azim_2 = -30;
aoa_elev_2 = 0;

true_AOA_x_1 = (aoa_azim_1)*(pi/180);
true_AOA_y_1 = (aoa_elev_1)*(pi/180);

true_AOA_x_2 = (aoa_azim_2)*(pi/180);
true_AOA_y_2 = (aoa_elev_2)*(pi/180);


%% SELECT TRUE AOA

true_AOA_x = true_AOA_x_1;
true_AOA_y = true_AOA_y_1;

%%
%linear array spacing
pos_elements_x = [0 0.0083 0.0125 0.025]; %meters
pos_elements_y = [0 0.0083 0.0125 0.025]; %meters


check = 250;
snrs = 22;
simulations = snrs*check-1;

%storing snr, error
data_x = zeros(2,simulations);
data_y = zeros(2,simulations);

false_alarm_count = 0;


%% MONTE-CARLO ! :) WOOHOO!
snr = 0;
for sim_number =1:simulations

    if mod(sim_number,check) == 0
        snr = snr + 1;
    end
    %% GENERATING  MULTISIGNAL WAVEFORMS

    

%     %signal parameters
%     n = 16000; %constant for now
%     f_samp = 4e9; %constant
%     f_sig = 0.5e9; %constant
%     f_lo = 17.5e9;
%     f_rf = f_sig+f_lo;
%     duty = 0.1; %1 percent
%     threshold_factor = 2;
%     
%     %signal = cw_gen(n,f_samp,f_sig);
%     %signal = pulse_gen(n,duty).*sin((1:1:n)*2*pi*f_sig*(1/f_samp));
%     signal = chirp_gen(n,f_samp,500e6,2.5e6, 0.00001);
%  
%     %used to determine a false alarm 
%     I_known = find_true_index(signal);
%     
%     %conditioning signals with noise and phase 
%     signals_x = condition_signal(signal, pos_elements_x, f_rf, true_AOA_x, snr); 
%     signals_y = condition_signal(signal, pos_elements_y, f_rf, true_AOA_y, snr);
%     
%     signals_x = awgn(signals_x,snr,"measured");
%     signals_y = awgn(signals_y,snr,"measured");
%     
%     samples = n;
%     
    %% MULTI SIG CASE
    
    n = 16000;
    
    f_samp = 4e9;
    
    duty = 0.1;
    
    f_lo = 6e9;
    
    threshold_factor = 2;
  
    f1 = 500e6;
    f2 = 1000e6;
    
    f_rf_1 = f1+f_lo;
    f_rf_2 = f2+f_lo;
    f_rf = f_rf_1;
    
%     signal_1 = pulse_gen(n,duty);
%     signal_2 = pulse_gen(n,duty);
% 
%     %shifting to desired frequency
%     signal_1 = signal_1.*sin(2*pi*f1*(1/f_samp)*(1:1:n));
%     signal_2 = signal_2.*sin(2*pi*f2*(1/f_samp)*(1:1:n));
    
    signal_1 = cw_gen(n,f_samp,f1);
    signal_2 = cw_gen(n,f_samp,f2);
    I_known_1 = find_true_index(signal_1);
    I_known_2 = find_true_index(signal_2);
    I_known = [I_known_1 I_known_2];
    
    signals_x_1 = condition_signal(signal_1, pos_elements_x, f_rf_1, true_AOA_x_1); 
    signals_y_1 = condition_signal(signal_1, pos_elements_y, f_rf_1, true_AOA_y_1);
    
    signals_x_2 = condition_signal(signal_2, pos_elements_x, f_rf_2, true_AOA_x_2); 
    signals_y_2 = condition_signal(signal_2, pos_elements_y, f_rf_2, true_AOA_y_2);
    
    signals_x_3 = signals_x_1 + signals_x_2;
    signals_y_3 = signals_y_1 + signals_y_2;
    
    signals_x_3 = awgn(signals_x_3,snr,"measured");
    signals_y_3 = awgn(signals_y_3,snr,"measured");
    
    
    SIGNALS_x_3 = fftshift(fft(signals_x_3));
    SIGNALS_y_3 = fftshift(fft(signals_y_3));
    %SIGNAL_3 = awgn(SIGNAL_3, , "measured");
    
    
    signals_x = signals_x_3;
    signals_y = signals_y_3; 
    
    %% TAKING FFT

    [SIGS_X, ~] = half_fft(signals_x);
    [SIGS_Y, ~] = half_fft(signals_y);
    
    %% FINDING WHERE SIGNAL IS PRESENT
    
    %element phases are normalised 
    [element_phases_x, element_cmplx_voltages_x, frequency_indicies_x] = find_sigs(SIGS_X,threshold_factor);
    [element_phases_y, element_cmplx_voltages_y, frequency_indicies_y] = find_sigs(SIGS_Y,threshold_factor);
 
    %created to keep track of original index-frequency relationship
    orig_freq_indicies_x = frequency_indicies_x;
    orig_freq_indicies_y = frequency_indicies_y;
    
    %% TAKING MIDPOINT OF CONTINUOUS THRESHOLDS

  
    %at this point have selected all actual frequency values
    frequency_indicies_x = threshold_midpoint(frequency_indicies_x);
    frequency_indicies_y = threshold_midpoint(frequency_indicies_y);
    %complicated as a by product of previous code
    %the fft take the max index as 0hz reference
    
    frequencies = (length(SIGS_X) - frequency_indicies_x +1)*(f_samp/n) + f_lo;
    
    %% FINDING FALSE ALARMS -NOT IMPLEMENTED
    
    true_indicies = 	frequency_indicies_x;

    %% CALCULATING ELEMENT PHASES
    
    %selecting row of phase values corresponsing to set of antenna elements
    
    original_freq_phase_index_x =  find(orig_freq_indicies_x == 6002);
    original_freq_phase_index_y =  find(orig_freq_indicies_y == 6002);
    
    single_elements_phases_x = element_phases_x(:,original_freq_phase_index_x ).';
    single_elements_phases_y = element_phases_y(:,original_freq_phase_index_y ).';
    
    %calculating differential wrt to first element - normalised
    diff_phases_x = (single_elements_phases_x - single_elements_phases_x(1));
    diff_phases_y = (single_elements_phases_y - single_elements_phases_y(1));
    %% CALCULATING RECIEVER DETERMINED AOA
    
    foi = f_rf;
    
    %max frequency is defined by the demodulation process
    calculated_AOA_x = aoa(foi,pos_elements_x, diff_phases_x);
    calculated_AOA_y = aoa(foi,pos_elements_y, diff_phases_y);
   

    %% CALCULATING ERROR
    
    %rad
    error_x = true_AOA_x - calculated_AOA_x;
    error_y = true_AOA_y - calculated_AOA_y;
    
    %% STORING STATE INFORMATION
    
    data_x(1,sim_number) = snr;
    %in radians
    data_x(2,sim_number) = error_x;
    data_x(3,sim_number) = calculated_AOA_x;
    data_x(4,sim_number) = true_AOA_x;
    
    data_y(1,sim_number) = snr;
    %in radians
    data_y(2,sim_number) = error_y;
    data_y(3,sim_number) = calculated_AOA_y;
    data_y(4,sim_number) = true_AOA_y;


end

%rad
data_x(2,:) =  (data_x(2,:))*180/pi;
data_y(2,:) =  (data_y(2,:))*180/pi;

rmse_x = zeros(1,snrs-1);
rmse_y = zeros(1,snrs-1);

%calcualting rmse for incremented SNR
for s = 1:(snrs-1)
    
       rmse_x(1,s) = sqrt(mean(data_x(2,(s-1)*check +1:(s*check)).^2));
       rmse_y(1,s) = sqrt(mean(data_y(2,(s-1)*check +1:(s*check)).^2));

end
%%

sgtitle(["MONTE CARLO SIMULATION RESULTS FOR A 6.5GHZ CONTINUOUS WAVE IN THE PRESENT OF A SECOND 7GHZ SIGNAL SHOWING ";...
        "ERROR METRICS IN AZIMUTH AND ELEVATION AS A FUNCTION OF SNR (250 SIMULATIONS PER SNR)"])

%plotting results
subplot(2,2,1)
scatter(data_x(1,:),data_x(2,:))
title("SCATTER PLOT OF ERROR IN AZIMUTH AS A FUNCTION OF SNR")
xlabel("SNR(dB)")
ylabel("Error (deg)")
xlim([0 20])

subplot(2,2,2)
scatter(data_y(1,:),data_y(2,:))
title("SCATTER PLOT OF ERROR IN ELEVATION AS A FUNCTION OF SNR")
xlabel("SNR(dB)")
ylabel("Error (deg)")
xlim([0 20])

subplot(2,2,3)
scatter((1:1:21) - 1,rmse_x)
title("SCATTER PLOT OF RMSE ERROR IN AZIMUTH AS A FUNCTION OF SNR")
xlabel("SNR(dB)")
ylabel("RMSE Error")


subplot(2,2,4)
scatter((1:1:21) - 1,rmse_y)
title("SCATTER PLOT OF RMSE ERROR IN ELEVATION AS A FUNCTION OF SNR")
xlabel("SNR(dB)")
ylabel("RMSE Error")

%%

figure
plot((1:1:length(SIGS_X))*(f_samp/n)+f_lo,fliplr(abs(SIGS_X)))
title("FFT OF 2 RECEIVED PULSES WITHIN THE SAME SAMPLING PERIOD (6.5 AND 7 GHZ)")
xlabel("Frequency (Hz)")
ylabel("Amplitude")
xlim([6e9 8e9])


