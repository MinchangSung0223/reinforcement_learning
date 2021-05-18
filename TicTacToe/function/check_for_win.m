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