classdef PolicyIteration
   properties
        env = [];
        value_table = [];
        policy_table = [];
        discount_factor=[];
   end
   
   methods
       function obj=PolicyIteration(env)
         obj.env = env;  
         obj.value_table = zeros(env.WIDTH,env.HEIGHT);
         obj.policy_table = repmat(reshape([0.25,0.25,0.25,0.25],1,1,[]),env.WIDTH,env.HEIGHT)
         obj.discount_factor = 0.9;
         obj.policy_table(env.circle_position(1)+1,env.circle_position(2)+1,:)=0
       end
       
       function policy_evaluation(obj)
       end
       
       function policy_improvement(obj)
           
       end
       
       function ind=get_action(obj,state)
       % 0~1 사이의 값을 무작위로 추출
            random_pick = rand
            policy = obj.get_policy(state)
            policy_sum = 0.0;
            % 정책에 담긴 행동 중에 무작위로 한 행동을 추출 
            for i = 1:1:4
                value = policy(i);
                policy_sum = policy_sum+value;
                if random_pick <policy_sum
                    ind = i-1;
                end
            end
       end
       
       
       function val = get_policy(obj,state)
           if state(1) ==2 && state(2) == 2
               val = [0,0,0,0];
           end
           val = reshape(obj.policy_table(state(1)+1,state(2)+1,:),1,[])
       end
       
       function val=get_value(obj,state)
           val = round(obj.value_table(state(1)+1,state(2)+1),2)
       end
       
       
   end
   
end