clc;
clear;
close all;

global HIT
global STICK
global WIN
global LOSE
global DRAW
global gamma

gamma =1
HIT = 1  % 한장 더 받기
STICK = 2 % 건너뛰기

WIN=1;
LOSE=2;
DRAW =3;

A = [HIT,STICK]
S = [];
for i = 1:1:10
    for j = 1:1:10
        for k = 1:1:3
            S = [S; i+11,j,k-1];
        end
    end
end
% 
% for i=1:1:length(S)
%     s = S(i,:);
%     for a=A
%         disp("S = "+string(s(1))+","+string(s(2))+","+string(s(3))+"   |   A = "+string(a))
%     end
% end

episode_num = 500000;
Returns = cell(300,1);
V = zeros(10,10,3);
for k = 1:1:episode_num
    [reward_,state_trajectory,action_trajectory] = play_blackjack; 
    
    reward = zeros(size(state_trajectory,1),1);
    reward(end+1) = reward_;
    
    
    G = 0;
    T =size(state_trajectory,1);
    for t= T:-1:1
        
        G = gamma*G + reward(t+1);
        s= state_trajectory(t,:);
        same_num =0;
        for tt = t-1:-1:1
            s_ = state_trajectory(tt,:);
            if s(1) == s_(1) && s(2) == s_(2) && s(3) == s_(3)
                same_num = same_num+1;
            end
        end
        if same_num==0
            index = find_state_index(s,S);
            Returns{index} = [Returns{index} ,G];
            V(s(1)-11,s(2),s(3)+1) = mean(Returns{index});
        end
    end
end
V = reshape(V,10,10,3);
[X,Y] = meshgrid(1:1:10,12:1:21);
surf(X,Y,V(:,:,1))
figure;
surf(X,Y,V(:,:,2))
figure
surf(X,Y,V(:,:,3))





 function [reward,state_trajectory,action_trajectory] = play_blackjack
global HIT
global STICK
global WIN
global LOSE
global DRAW
global gamma

    
    ALL_CARD_NUM = 11;
    policy_player = zeros(10,10,3); % 12 ~ 21 , 1 ~ 10, 0 ~ 2
    policy_player(12-ALL_CARD_NUM :17-ALL_CARD_NUM ,:,:)=HIT ;% 12~19
    policy_player(18-ALL_CARD_NUM :21-ALL_CARD_NUM ,:,:)=STICK;

    policy_dealer = zeros(10,10,3);
    policy_dealer(12-ALL_CARD_NUM :16-ALL_CARD_NUM ,:,:)=HIT;
    policy_dealer(17-ALL_CARD_NUM :21-ALL_CARD_NUM ,:,:)=STICK;

    [player_sum,usable_ace_player,player_card_list]=get_card_valuesum(get_card,get_card);
    [dealer_sum,usable_ace_dealer,dealer_card_list]=get_card_valuesum(get_card,get_card);
    
    dealer_player_state = [dealer_sum,dealer_card_list(1),usable_ace_dealer];
    player_state = [player_sum,dealer_card_list(1),usable_ace_player];
    % Player's turn

    player_action = get_action(player_state,policy_player);
    count = 0;
    clc;
    state_trajectory = [];
    action_trajectory = [];
    if player_state(1)>11
        state_trajectory = [player_state];
         action_trajectory = [player_action];
    end
    while (player_action~=STICK)
%         player_action = get_action(player_state,policy_player);
        player_action = get_action(player_state,policy_player);
        

%         if player_action == HIT
%             disp("Player - count "+string(count)+",sum : "+string(player_state(1))+", usable_ace :"+string(player_state(3))+", action : "+"HIT");
%         else
%             disp("Player - count "+string(count)+",sum : "+string(player_state(1))+", usable_ace :"+string(player_state(3))+", action : "+"STICK");
%         end
        [player_state,player_card_list ] = next_state(player_state,player_action,player_card_list);
        if player_state(1)>21
            break;
        end
        if player_state(1)>11
            state_trajectory = [state_trajectory;player_state];
            action_trajectory = [action_trajectory;player_action];
        end
        count = count+1;
        
    
    end
%     disp("Player Result - all_sum : "+string(player_state(1))+", usable_ace : "+string(player_state(3)))
%     disp("--------------player_card_list -------------");
%     disp(player_card_list);

    % Dealer's turn   
    dealer_action = get_action(dealer_player_state,policy_dealer);

    count = 0;
    while (dealer_action~=STICK)
        dealer_action = get_action(dealer_player_state,policy_dealer);
       
%         if dealer_action == HIT
%             disp("Player - count "+string(count)+",sum : "+string(dealer_player_state(1))+", usable_ace :"+string(dealer_player_state(3))+", action : "+"HIT");
%         else
%             disp("Player - count "+string(count)+",sum : "+string(dealer_player_state(1))+", usable_ace :"+string(dealer_player_state(3))+", action : "+"STICK");
%         end
%         
        [dealer_player_state ,dealer_card_list]= next_state(dealer_player_state,dealer_action,dealer_card_list);
        if dealer_player_state(1)>21
            break;
        end
        count = count+1;

    end
%     disp("Dealer Result - all_sum : "+string(dealer_player_state(1))+", usable_ace : "+string(dealer_player_state(3)))
%     disp("--------------delear_card_list -------------");
%     disp(dealer_card_list);

    [reward,result] = get_reward(player_state,dealer_player_state);
%     if result == WIN
%         disp("Player WIN")
%     elseif result == LOSE
%         disp("Player LOSE")
%     elseif result == DRAW
%         disp("DRAW")
%     end
 end

 function [reward,result]=get_reward(player_state,dealer_state)
global DRAW
global WIN
global LOSE
reward = 0;
result = 0;
    if player_state(1) == dealer_state(1)   
        reward = 0;
        result = DRAW;
        return;
    end
    if player_state(1) ==22 && dealer_state(1)<22
        reward = -1;
        result = LOSE;
        return;
    end
    if dealer_state(1) ==22 && player_state(1)<22
        reward = 1;
        result = WIN;
        return;
    end
    if player_state(1) > dealer_state(1)
        reward = 1;
        result = WIN;
        return;
    end
    if dealer_state(1) > player_state(1)
        reward = -1;
        result = LOSE;
        return;
    end    
 end
 
function [player_sum,usable_ace_player,card_list]=get_card_valuesum(card1,card2)
    card_list = [card1,card2];
    player_sum= 0;
    usable_ace_player = false;
    value1 = get_card_value(card1);
    value2 = get_card_value(card2); 
    player_sum = value1+value2; 

    if player_sum < 12
        player_sum = player_sum;
        usable_ace_player = 0;
        return;
    else
       if player_sum < 22
           if player_sum ==21
               player_sum = 21;
               usable_ace_player= 0;
               return;
           end
           
           if value1 ==11 || value2 == 11
                player_sum = player_sum-10;
                usable_ace_player = 1;
                return;
           else
               player_sum = player_sum;
               usable_ace_player = 0;
               return;
           end
       elseif player_sum >21
            if value1 ==11 && value2 ==11
                usable_ace_player = 2;
                player_sum = player_sum-20;
                return;
            end
       end
    end
        
    
end

function  player_action = get_action(state,policy_player)
global HIT
global STICK
if state(1)>21
    player_action = STICK;
    return;
end
if state(1)<12
    player_action = HIT;
    return;
else
    player_action = policy_player(state(1)-11,state(2),state(3)+1);
    return;
end

end








