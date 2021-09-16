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
        
        %calculating ambiguities from normalised phase shift
        fine_diff_phases(1,i) =  phase_diff/(2*pi) + range(i);
        
    end
    
     fine_diff_phases =  fine_diff_phases*2*pi;
    
end

