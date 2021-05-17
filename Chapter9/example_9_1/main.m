global N_STATES
global START_STATE
global END_STATES
global STEP_RANGE

N_STATES = 1000
START_STATE = 500;
END_STATES = [0, N_STATES + 1]
STEP_RANGE = 100
EPISODES = 100000;
STATES = 1:1:N_STATES

alpha = 2*10^(-5);
group_size = 10;
V = zeros(group_size,1)
distribution=zeros(N_STATES+2,1);
 tic
for ep = 1:1:EPISODES
     [state_trajectory,reward]=play_randomwalk;
     for i = 1:1:length(state_trajectory)
         s = state_trajectory(i);
         delta = alpha * (reward - get_Value(V,s));
         V = update_Value(V,s,delta);
         distribution(s+1)=distribution(s+1)+1;
     end  
end

toc
values = []
for s = STATES
   values=[values, get_Value(V,s)];
end
distribution = distribution./sum(distribution);
plot(STATES,distribution(2:end-1))
figure;
plot(STATES,values)
function val=get_Value(V,s)
    global STEP_RANGE
    if check_terminal_state(s)==1
        val=0;
    elseif check_terminal_state(s)==0
        group_index = floor((s)/(STEP_RANGE))+1;
        if group_index==11
             group_index = 10;
         end
        val = V(group_index);
    end
end
function V=update_Value(V,s,delta)
    global STEP_RANGE
    group_index = floor((s)/(STEP_RANGE))+1;
    if group_index==11
        group_index = 10;
    end
    V(group_index) = V(group_index) +delta;
end
function ret = check_terminal_state(state)
    global END_STATES
    ret = 0;
    for i =END_STATES
        if i==state
            ret=1;
        end
    end
end

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
        state_trajectory(end+1) = state;
        [state,reward]=next_state(state,action);
        if check_terminal_state(state)==1
            break;
        end
        
    end
    
end

function action = get_action
    if rand>0.5
        action= 1;
    else
        action = -1;
    end
end
function [state,reward] = next_state(state,action)
    global N_STATES
    global STEP_RANGE
    step=action*(floor(rand*(STEP_RANGE))+1);
    state = state+step;
    state = max([min([state, N_STATES + 1]), 0]);
    reward =get_reward(state);

    
end
function reward=get_reward(state)
    global N_STATES
    if state ==0
        reward = -1;
    elseif state==N_STATES+1
        reward=1;
    else
        reward=0;
    end
end
