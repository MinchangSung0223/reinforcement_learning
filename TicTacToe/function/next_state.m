function [ret,S] = next_state(S,action)
    S(action) = 1;
    ret=0;
    if check_terminal_state(S)
        ret=1;
        return;
    end
    %% player2_turn
    player2_action = choose_random_action(S);
    S(player2_action) = -1;
    
    if check_terminal_state(S)
        ret=1;
        return;
    end
end