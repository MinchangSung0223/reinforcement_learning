function [state_trajectory,reward]=play_randomwalk
    global N_STATES
    global START_STATE
    global END_STATES
    global STEP_RANGE
    state_trajectory=[];
    state = START_STATE;
    reward = 0;
    while(1)
        action = get_action();
        [state,reward]=next_state(state,action);
        state_trajectory(end+1) = state;
        if sum(state == END_STATES)>0
            break;
        end
    end
    
end

function action = get_action

    if binornd(1, 0.5) == 1
        action= 1;
        return;
    end
    action=-1;
    return;
end
function [state,reward] = next_state(state,action)
    global N_STATES
    global STEP_RANGE
    
    move_value=action*floor(rand*STEP_RANGE)+1;
    state = state+move_value;
    state = max([ min([state,N_STATES+1]),0]);
    reward =get_reward(state);
end
function reward=get_reward(state)
    global N_STATES
    if state <=0
        reward = -1;
    elseif state>=N_STATES+1
        reward=1;
    else
        reward=0;
    end
       
end