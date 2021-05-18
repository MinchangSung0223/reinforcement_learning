addpath("function")
close all;
clear;
episode_num  = 10000;
alpha=0.5
load all_states.mat
%%%%%%%%%%%%%%%%%%%%FIRST VISIT MONTECARLO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Returns = cell(size(All_States,1),1);
V = zeros(size(All_States,1),1);
gamma = 1;
meanV1=  []
zero_state = find_state_index([0 0 0 0 0 0 0 0 0],All_States);

for k = 1:1:episode_num
    [reward_,state_trajectory,action_trajectory] = play_tictactoe; 
    reward =reward_;
    G = 0;
    T =size(state_trajectory,1);
    for t= T:-1:1
        G = gamma*G + reward(t+1);
        s= state_trajectory(t,:);
        same_num =0;
        for tt = t-1:-1:1
            s_ = state_trajectory(tt,:);
            if is_same_state(s_,s)==1
                same_num=same_num+1;
            end
        end
        if same_num==0
            index = find_state_index(s,All_States);
            Returns{index} = [Returns{index} ,G];
            V(index) = V(index)+alpha*(G-V(index));
        end
    end
    meanV1 = [meanV1,mean(V(:))];
    
end
plot(1:1:episode_num,meanV1,"r-");
save MC.mat
hold on;


%%%%%%%%%%%%%%%%%%%%EVERYVISIT & TD(0)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath("function")
clear;
episode_num  = 10000;


load new_all_states.mat
All_States = new_All_States;
Returns = cell(size(All_States,1),1);
V = zeros(size(All_States,1),1);
V_MC = zeros(size(All_States,1),1);
alpha=0.5
gamma = 1;
meanV=  []
meanV22=[]
zero_state = find_state_index([0 0 0 0 0 0 0 0 0],All_States);
initial_state = [0,0,0,0,0,0,0,0,0];
for k = 1:1:episode_num
    
    state = initial_state;
    G = 0;
    while(1)
           player1_action = choose_random_action(state);
           [next_state_,reward]=get_reward(state,player1_action); 
           state_index = find_state_index(state,All_States);
           next_state_index = find_state_index(next_state_,All_States);
          state = next_state_;
          V(state_index) = V(state_index) +alpha*(reward+gamma*V(next_state_index)-V(state_index)) ;
          V_MC(state_index) = V_MC(state_index)+alpha*(reward-V_MC(state_index));

          ret=check_terminal_state(state);
                if check_terminal_state(state)
            %         draw_tictactoe(state,ret)
                    break;
                end
    end      
    meanV = [meanV,mean(V(:))];
    meanV22 = [meanV22,mean(V_MC(:))];
    
end
save TD0.mat

plot(1:1:episode_num,meanV,"b-");
plot(1:1:episode_num,meanV22,"g-");







