function [element_phases, element_cmplx_voltages, frequency_indicies] = ...
                                                  find_sigs(SIGS,threshold_factor)
    
    %---------------------------------------------------------------------
    %find_sigs - finds a signal present in fft
    %---------------------------------------------------------------------
    %SIGS single sided FFT of signal
    %threshold_factor - how many times greater response need to be with
    %                   respect to average to be conisidered a signal
    %---------------------------------------------------------------------
    
    %only looking at a single element as IT IS ASSUMED SIGNAL PRESENT ON
    %ONE WILL BE PRESENT IN OTHER CHANNELS
    single_channel = SIGS(1,:);

    %taking average of channel to determine signal threshold
    ave = mean(abs(single_channel));
    
    %finding indexes of frequencies that have N*average signal power
    frequency_indicies = find(abs(single_channel) > threshold_factor*ave);
    
    %finding the complex value of where signals present
    element_cmplx_voltages = SIGS(:,frequency_indicies);
   
    %computing the phase of these signals - NORMALISED
    element_phases = angle(element_cmplx_voltages)/(2*pi);

end

