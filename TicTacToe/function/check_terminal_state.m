function ret = check_terminal_state(next_state)
        ret = 0;
        next_s = [next_state(1) next_state(2) next_state(3);...
                        next_state(4) next_state(5) next_state(6);...
                        next_state(7) next_state(8) next_state(9); ];
        win_value = check_for_win(next_s);
        end_value=check_for_end(next_s);
        if win_value ==0 && end_value ==1
            %draw
            ret = 1;
            return;
        elseif win_value ==1
            %player 1 win
            ret =1;
            return;
        elseif win_value ==-1
            %player 2 win
            ret =1;
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