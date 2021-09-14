function [SIGS SIGS_shift] = half_fft(sigs)
    
    %---------------------------------------------------------------------
    %half_fft: will return one side of the FFT'ed function. Gain of fft
    %               reduced to 1
    %---------------------------------------------------------------------
    %sig - signal to be FFT'ed
    %SIGS_shift - FFT'ed array to be used for frequency calculation 
    %                                                (if desired)
    %---------------------------------------------------------------------
    
    SIGS = (fft(sigs,[],2)./length(sigs));
    SIGS_shift = fftshift((fft(sigs,[],2)./length(sigs)));
    
    SIGS = SIGS(:,length(SIGS)/2:end);
    
end

