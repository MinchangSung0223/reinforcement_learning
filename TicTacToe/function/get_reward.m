function [next_state_,reward]=get_reward(state,action)
    reward=0;
    [end_value,next_state_] = next_state(state,action);
    next_s = [next_state_(1) next_state_(2) next_state_(3);...
                        next_state_(4) next_state_(5) next_state_(6);...
                        next_state_(7) next_state_(8) next_state_(9); ];
    win_value = check_for_win(next_s);
    if win_value ==0 && end_value ==1
        %draw
        reward = 0;
        return;
    elseif win_value ==1
        %player 1 win
        reward =1;
        return;
    elseif win_value ==-1
        %player 2 win
        reward =1;
        return;
    end              
                    
end


function win_value =check_for_win(S)
    win_value = 0;
    %if win_value is 1   =>   O win
    %   win_value is -1  =>    X win
    %   win_value is 0   =>    draw or not yet end
    %check diagonal
    if abs(S(1,1)+S(2,2)+S(3,3))==3
        if S(1,1)+S(2,2)+S(3,3)>0
            win_value = 1;
            return;
        elseif S(1,1)+S(2,2)+S(3,3)<0
            win_value = -1;
            return;
        end
    end
    if abs(S(1,3)+S(2,2)+S(3,1))==3
        if S(1,3)+S(2,2)+S(3,1)>0
            win_value = 1;
            return;
        elseif S(1,3)+S(2,2)+S(3,1)<0
            win_value = -1;
            return;
        end
    end
    
    for i =1:1:3
        if abs(sum(S(i,:)))==3
            if sum(S(i,:))>0
                win_value = 1;
                return;
            elseif sum(S(i,:))<0
                win_value = -1;
                return;
            end
        end
         if abs(sum(S(:,i)))==3
            if sum(S(:,i))>0
                win_value = 1;
                return;
            elseif sum(S(:,i))<0
                win_value = -1;
                return;
            end
        end
    end
    
end

function ret = check_for_end(S)
    ret = 0;
    if sum(sum(abs(S)))==9
        ret =1;
        return;
    end
end