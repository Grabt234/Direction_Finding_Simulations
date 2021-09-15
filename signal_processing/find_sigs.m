function [element_phases, element_cmplx_voltages, frequency_indicies] = ...
                                                            find_sigs(SIGS)
    
    %---------------------------------------------------------------------
    %find_sigs: will find array values and positions that meet magnitude
    %              criteria - i.e where one thinks a signal is
    %---------------------------------------------------------------------
    %element_phases - single sided fft of signals
    %element_cmplx_voltages - cmplx vlaues of sig
    %frequency_indicies - index where sig present
    %---------------------------------------------------------------------
    
    %only looking at a single element as IT IS ASSUMED SIGNAL PRESENT ON
    %ONE WILL BE PRESENT IN OTHER CHANNELS
    single_channel = SIGS(1,:);

    %taking average of channel to determine signal threshold
    ave = mean(abs(single_channel));
    
    %finding indexes of frequencies that have N*average signal power
    frequency_indicies = find(abs(single_channel) > 10*ave);
    
    %finding the complex value of where signals present
    element_cmplx_voltages = SIGS(:,frequency_indicies);
   
    %computing the phase of these signals - NORMALISED
    element_phases = angle(element_cmplx_voltages)/(2*pi);

end

