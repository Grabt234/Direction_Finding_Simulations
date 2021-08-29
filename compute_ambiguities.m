function fine_diff_phases = compute_ambiguities(N, phase_diff)
    
    %---------------------------------------------------------------------
    %compute_ambiguities: computes the possible ambiguities for a give
    %                       and uncertainty number and differential phase
    %---------------------------------------------------------------------
    %M - ambiguity number
    %aoa - calculated angle of arrival
    %---------------------------------------------------------------------
    
    
    %ambigous phase step
    %phase_step = pi/(N);
    
    %preallocating memory
    fine_diff_phases = zeros(1,ceil(N));
    
    range = -floor(N):1:floor(N);
    
    for i = 1:numel(range)
        
        range(i)
        
        fine_diff_phases(1,i) =  phase_diff + range(i);
        
    end
    
    %shifting back into correct range - see ED support notes
    %fine_diff_phases = wrapTo2Pi(fine_diff_phases);

    
end

