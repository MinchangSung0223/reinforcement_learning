function [reward_trajectory,state_trajectory,action_trajectory]=play_tictactoe
    close all;
    state_trajectory = [];
    action_trajectory = [];
    reward_trajectory =[];
    initial_state= [0 0 0 0 0 0 0 0 0];
    
    state = initial_state;
    reward_trajectory(end+1) = 0;
    while(1)
    state_trajectory(end+1,:)=state;
    
    
    %% player1_turn
    
    player1_action = choose_random_action(state);
    [next_state_,reward]=get_reward(state,player1_action);
    
    
    action_trajectory(end+1) = player1_action;    
    reward_trajectory(end+1) = reward;
    state = next_state_;
    
    ret=check_terminal_state(state);
    if check_terminal_state(state)
%         draw_tictactoe(state,ret)
        break;
    end
%     draw_tictactoe(state,ret)
%     pause(0.1);
    
    end
    
end