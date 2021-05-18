function index =find_state_index(s,All_States)
    temp_s = [s(1) s(2) s(3) s(4) s(5) s(6) s(7) s(8) s(9)];
    state_list=get_same_state(temp_s);
    state_list(end+1,:) = temp_s;
    index = -1;
    for i=1:1:size(All_States,1)
        for k = 1:1:size(state_list,1)
            ss = state_list(k,:);
            if  ss==All_States(i,:)
                index = i;
                return;
            end
        end
    end
    
end