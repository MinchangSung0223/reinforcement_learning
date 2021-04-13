
global POSSIBLE_ACTION 
global  ACTION
global REWARD
global TRANSITION_PROB
global WIDTH
global HEIGHT

POSSIBLE_ACTION = [0,1,2,3] %left right up down
ACTION = [[-1,0];[1,0];[0,-1];[0,1]]
REWARD = []
TRANSITION_PROB = 1
WIDTH = 5;
HEIGHT = 5;

disp("time : 0 ")

circle_position = [2,2]
triangle_position = [1,2;2,1]
box_position = [0,0]
env = Environment(circle_position,triangle_position,box_position,POSSIBLE_ACTION,ACTION,REWARD,TRANSITION_PROB,WIDTH,HEIGHT)

value_table_ =zeros(5,5);
policy_table_ = repmat(reshape([0.25,0.25,0.25,0.25],1,1,[]),5,5);
for t = 0:1:10
    policy_iteration = PolicyIteration(env,value_table_,policy_table_);
    
    value_table_ = policy_iteration.policy_evaluation();
    policy_table_ = policy_iteration.policy_improvement();
    policy_iteration.get_value_table
    policy_iteration.get_policy_table
    
    input("time : "+ string(t+1)+"")
    
end
    