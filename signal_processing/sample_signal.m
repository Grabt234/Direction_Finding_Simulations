function sigs = sample_signal(sigs, start_pos, samples)
    
    %---------------------------------------------------------------------
    %sample_signal: given a signal, this will simulate sampling by
    %                   returning a portion of the signal
    %---------------------------------------------------------------------
    %sig - signal to be samples
    %start_pos - the point in the signal from which to start sampling
    %samples - the number of samples one wishes to take
    %---------------------------------------------------------------------
    
    if(start_pos + sample > length(sigs))
        
        %in the case where not enough samples from start position, move
        %back in array
        move_back =   length(sigs) - (start_pos + sample);

        %note move back is negative
        start_pos = start_pos + move_back;

        sigs = sigs(:,start_pos:end);

    else
        
        %cut as usual
        sigs = sigs(:,start_pos:start_pos + samples);
    
    end    
    
end

