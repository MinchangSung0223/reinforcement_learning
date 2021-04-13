classdef Environment
   properties
      transition_probability = [];
      reward = [];
      ACTION =[];
      WIDTH =0;
      HEIGHT =0;
      possible_actions = [];
      all_state = [];
      circle_position=[];
      triangle_position=[];
      box_position=[];
      
   end
   methods
       function obj = Environment(circle_position,triangle_position,box_position,POSSIBLE_ACTION,ACTION,REWARD,TRANSITION_PROB,WIDTH,HEIGHT)
           obj.transition_probability = TRANSITION_PROB;
           obj.reward = zeros(WIDTH,HEIGHT);
           obj.possible_actions = POSSIBLE_ACTION;
           obj.ACTION=ACTION;
           obj.WIDTH=WIDTH;
           obj.HEIGHT=HEIGHT;
           obj.circle_position = circle_position;
           obj.triangle_position = triangle_position;
           obj.box_position =box_position;
           for x = 0:1:WIDTH-1
               for y = 0:1:HEIGHT-1
                    obj.all_state = [obj.all_state ;[x,y]];
               end
           end
           
           for i =1:1:size(circle_position,1)
                obj.reward(circle_position(i,1)+1,circle_position(i,2)+1) = 1;
           end
           
           for i =1:1:size(triangle_position,1)
                obj.reward(triangle_position(i,1)+1,triangle_position(i,2)+1) = -1;
           end
       end
       
       function reward = get_reward(obj,state,action)
           next_state = obj.state_after_action(state,action);
           reward = obj.reward(next_state(1)+1,next_state(2)+1);
       end
       
       function next_state=state_after_action(obj,state,action)
           action_ = obj.ACTION(action,:);
           val = [state(1)+action_(1),state(2)+action_(2)];
           next_state =  obj.check_boundary(val);
       end

       function state_ = check_boundary(obj,state)
           state_=[0,0];
           if state(1) <0 
            state_(1) =  0;
           elseif state(1)>obj.WIDTH-1
            state_(1) =  obj.WIDTH-1;
           else
             state_(1) = state(1);
           end
           
           if state(2) <0 
            state_(2) =  0;
           elseif state(2)>obj.HEIGHT-1
            state_(2) =  obj.HEIGHT-1;
           else
             state_(2) = state(2);
           end
           
       end
       
       function transition_prob = get_transition_prob(obj,state,action)
           transition_prob = obj.transition_probability;
       end
       
       function get_all_state = get_all_states(obj)
           get_all_state = obj.all_state;
       end
       
       function draw_reward(obj)
           figure(2);
           draw_board(0);
           s = size(obj.reward);
           [X,Y] = meshgrid(0:1:4,0:1:4);
            X = reshape(X,1,[]);
            Y = reshape(Y,1,[]);
            R = reshape(obj.reward,1,[]);
            for i=1:1:length(X)
                text((X(i))*2+1,(4-Y(i))*2+1,string(R(i)));
            end
   
       end
       function change_box_position(obj,box_position)
           obj.box_position = box_position;
       end
           
        function draw(obj)
            
           clf;
           figure(1);
           hold on;
           obj.circle_position
           draw_all(obj.circle_position,obj.triangle_position,obj.box_position);
            
       end      
   end
end