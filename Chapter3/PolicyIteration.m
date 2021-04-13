classdef PolicyIteration
   properties
        env 
        value_table
        policy_table 
        discount_factor
   end
   
   methods
       function obj=PolicyIteration(env,value_table,policy_table)
         obj.env = env;  
         obj.value_table = value_table;
         obj.policy_table = policy_table;
         obj.discount_factor = 0.9;
         obj.policy_table(env.circle_position(1)+1,env.circle_position(2)+1,:)=0
       end
       
       function val = policy_evaluation(obj)
            
           % 다음 가치함수 초기화
           next_value_table  = zeros(obj.env.WIDTH,obj.env.HEIGHT);
           %모든 상태에 대해서 벨만 기대방정식을 계산
            get_all_states = obj.env.get_all_states;
           for i = 1:1:length(get_all_states)
                  state = get_all_states(i,:);
                  value= 0.0;
                  % 마지막 상태의 가치함수 =0;
                  if state(1)==2 && state(2)==2
                       next_value_table(state(1)+1,state(2)+1) = value;
                       continue
                  end
                  
                 for j = 1:1:length(obj.env.possible_actions)
                     action = obj.env.possible_actions(j)+1;
                     next_state  = obj.env.state_after_action(state,action);
                     reward = obj.env.get_reward(state,action);
                     next_value = obj.get_value(next_state);
                     get_policy = obj.get_policy(state);
                     value = value+(get_policy(action)*(reward+obj.discount_factor*next_value));
                 end
                 next_value_table(state(1)+1,state(2)+1) = round(value,2);
           end
             obj.value_table = next_value_table;
             val = next_value_table;
       end
       % 현재 가치 함수에 대해서 탐욕 정책 발전
       function val = policy_improvement(obj)
           next_policy = obj.policy_table;
           get_all_states_ = obj.env.get_all_states;
           for i = 1:1:length(get_all_states_)
               state = get_all_states_(i,:);
               if state(1)==2 && state(2)==2
                   continue;
               end
               value = -99999;
               max_index = [];
               %반환할 정책 초기화

               result = [0,0,0,0];
               
               %모든 행동에 대해서 [보상+(감가율 * 다음 상태 가치함수)] 계산
               for j = 1:1:4
                   action = obj.env.possible_actions(j)+1;
                   next_state = obj.env.state_after_action(state,action);
                   reward = obj.env.get_reward(state,action);
                   
                   next_value = obj.get_value(next_state);
                   temp = reward + obj.discount_factor*next_value;
                   if temp == value
                       max_index(end+1) = j;
                   elseif temp>value
                       value = temp;
                       max_index= [];
                       max_index(1) = j;
                   end
               end
               prob = 1/length(max_index);
               for jj = 1:1:length(max_index)
                     result(max_index(jj)) = prob;
               end
               disp(string(state(1))+","+string(state(2))+" : "+string(result(1))+","+string(result(2))+","+string(result(3))+","+string(result(4)))
               next_policy(state(1)+1,state(2)+1,:)=result;
           end
          obj.policy_table = next_policy;
          val = next_policy;
       end
       
       function ind=get_action(obj,state)
       % 0~1 사이의 값을 무작위로 추출
            random_pick = rand
            policy = obj.get_policy(state);
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
           val = reshape(obj.policy_table(state(1)+1,state(2)+1,:),1,[]);
       end
       
       function val=get_value(obj,state)
           val = round(obj.value_table(state(1)+1,state(2)+1),2);
       end
      function value_table=get_value_table(obj)
           value_table = obj.value_table;
       end
      function policy_table=get_policy_table(obj)
           policy_table = obj.policy_table;
       end  
   end
   
end