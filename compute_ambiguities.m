function ambiguous_aoa = compute_ambiguities(M, aoa)
    
    %---------------------------------------------------------------------
    %compute_ambiguities: computes the possible ambiguities for a give
    %                       and uncertainty number and differential phase
    %---------------------------------------------------------------------
    %M - ambiguity number
    %aoa - calculated angle of arrival
    %---------------------------------------------------------------------
    
    %ambigous phase step
    phase_step = pi/(M+1);
    
    %preallocating memory
    ambiguous_aoa = zeros(1,M+1);
    
    for i = 1:M+1
       
        ambiguous_aoa(1,i) =  aoa + (i-1)*phase_step;
        
    end
    
    %shifting back into correct range - see ED support notes
    %floor included by inspection
    %ambiguous_phis = (ambiguous_phis) - (M/2)*phase_step;
    
end

