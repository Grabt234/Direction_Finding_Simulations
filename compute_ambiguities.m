function ambiguous_phis = compute_ambiguities(M, differential_phase)
    
    %---------------------------------------------------------------------
    %compute_ambiguities: computes the possible ambiguities for a give
    %                       and uncertainty number and differential phase
    %---------------------------------------------------------------------
    %M - ambiguity number
    %differential_phase - calculated angle of arrival
    %---------------------------------------------------------------------
    
    %ambigous phase step
    phase_step = pi/M;
    
    %preallocating memory
    ambiguous_phis = zeros(1,M);
    
    for i = 1:M
       
        ambiguous_phis(1,i) =  differential_phase + (i-1)*phase_step;
        
    end
    
    %shifting back into correct range - see ED support notes
    ambiguous_phis = ambiguous_phis - (M/2)*phase_step;
    
end

