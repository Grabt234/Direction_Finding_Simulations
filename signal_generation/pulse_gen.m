function signal = pulse_gen(samples, duty_cycle)
    
    %---------------------------------------------------------------------
    %pulse_gen: produces a un modulated pulse signal
    %---------------------------------------------------------------------
    %samples - number of samples in the signal
    %duty_cyle - what portion of pulse is  "on"
    %---------------------------------------------------------------------
   
    %creatign pulse to turn into signal into a pulse
    signal = [ones(1,samples*duty_cycle) ...
                        zeros(1,samples*(1-duty_cycle))];


end

