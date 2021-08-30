function [element_phases, element_cmplx_voltages, frequency_indicies] = ...
                                                            find_sigs(SIGS)
    
    %---------------------------------------------------------------------
    %find_sigs: will find array values and positions that meet magnitude
    %              criteria - i.e where one thinks a signal is
    %---------------------------------------------------------------------
    %SIGS - single sided fft of signals
    %
    %---------------------------------------------------------------------
    
    %only looking at a single element as IT IS ASSUMED SIGNAL PRESENT ON
    %ONE WILL BE PRESENT OF ANOTHER
    single_channel = SIGS(1,:);

    %taking average of channel to determine signal threshold
    ave = abs(mean(single_channel));

    %finding indexes of frequencies that have N*average signal power
    frequency_indicies = find(abs(single_channel) > 300*ave);
    
    %finding the complex value of these signals
    element_cmplx_voltages = SIGS(:,frequency_indicies);
   
    %comuting the phase of these signals - NORMALISED
    element_phases = angle(element_cmplx_voltages)/(2*pi)

end

