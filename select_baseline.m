function baseline = select_baseline(element_positions,frequency)
    
    %---------------------------------------------------------------------
    %select_baseline: given a operation frequency one, the course baseline
    %                   will be selected
    %---------------------------------------------------------------------
    %array_positions - array positions in meters with index 1 
    %                           as reference 0 array [0 d1 d2]
    %frequency       - frequency one is monitoring at  
    %---------------------------------------------------------------------
    
    lambda = 3e8/frequency;
    max_baseline = lambda/2;
    
    %checks which elements meet base line requirements
    for i = 2:numel(element_positions)
        
        %check if base line requirement is met
        if element_positions(i) >= max_baseline
            
            baseline = element_positions(i);
            break
            
        end
        
    end
    
end
