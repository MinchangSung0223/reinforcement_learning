function ret = is_same_state(s1,s2)
    ret = 0;
    s1_list = get_same_state(s1);
    s2_list = get_same_state(s2);
    for i = 1:1:size(s1_list,1)
        for j = 1:1:size(s2_list,1)
            temp_s1 = s1_list(i,:);
            temp_s2 = s2_list(j,:);
            if temp_s1==temp_s2
                ret =1;
                return;
            end
            
        end
    end
    
    
end

function state_list=get_same_state(state1)
    s1 = [state1(1) state1(2) state1(3),...
        state1(4) state1(5) state1(6),...
        state1(7) state1(8) state1(9)];
   %flilp horizontal
   s2 = [state1(3) state1(2) state1(1),...
        state1(6) state1(5) state1(4),...
        state1(9) state1(8) state1(7)]; 
    %flilp vertical
   s3 = [state1(7) state1(8) state1(9),...
        state1(4) state1(5) state1(6),...
        state1(1) state1(2) state1(3)]; 
    %flilp point
    s4 = [state1(9) state1(6) state1(3),...
        state1(8) state1(5) state1(2),...
        state1(7) state1(4) state1(1)];    
     %flilp point
     s5 = [state1(1) state1(4) state1(7),...
        state1(2) state1(5) state1(8),...
        state1(3) state1(6) state1(9)];
    %Rotate
    s6 = [state1(7) state1(4) state1(1),...
        state1(8) state1(5) state1(2),...
        state1(9) state1(6) state1(3)];    
    %Rotate
    s7 = [state1(9) state1(8) state1(7),...
        state1(6) state1(5) state1(4),...
        state1(3) state1(2) state1(1)];    
    %Rotate
    s8 = [state1(3) state1(6) state1(9),...
        state1(2) state1(5) state1(8),...
        state1(1) state1(4) state1(7)];
    
    state_list=[s2;s3;s4;s5;s6;s7;s8];
    index=[];
    for  i = 7:-1:1
         s = state_list(i,:);
         for j=i-1:-1:1
             s_ = state_list(j,:);
             if s==s_
                 index=[index,j];
             end
         end
    end
    unique(index);
    state_list(index,:)=[];
end