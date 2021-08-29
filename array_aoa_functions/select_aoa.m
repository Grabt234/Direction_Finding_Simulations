function aoa = select_aoa(unambiguous_aoa, ambiguous_aoas)
    
    %---------------------------------------------------------------------
    %select_aoa: removes ambiguous aoa from fine aoa measurement
    %---------------------------------------------------------------------
    %course_aoa - the course aoa found previously
    %fine_aoas  - ambiguous set of aoas fromt the larger baseline angle
    %               measurement
    %---------------------------------------------------------------------

    %finding value closes to course aoa
    distance = abs(ambiguous_aoas - unambiguous_aoa);
    
    %finding the index of closest matching aoa
    [~, index] = min(distance);
    
    %return closest matching angle of arrival
    aoa = ambiguous_aoas(index);
        
    
end

