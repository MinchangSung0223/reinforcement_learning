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