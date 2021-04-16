clear;

%% 상태 정의 
%       0  1  2  3  
%       4  5  6  7
%       8  9  10 11
%       12 13 14 0

% s =0 은 종단 상태.

S = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 , 0];

%% 행동 정의
up = 1;
down = 2;
right = 3;
left = 4;
A = [up down right left] % up down right left
%% policy 정의
% 모두 같은 값을 갖는다 = 랜덤으로 4개중 하나를 선택한다.
p = [0.25 0.25 0.25 0.25];
% 각 상태에 대한 4개의 값을 갖는 policy table을 만든다.
policy = repmat(p,16,1);

%% 가치 함수 초기화
% v는 현재 상태의 가치함수
v = zeros(16,1);
% V는 다음 상태의 가치함수
V = zeros(16,1);
% 할인율
gamma = 1;


% 시행횟수 k
k=0
disp("----------------------------k : "+string(k)+"----------------------------")
disp("vk : ")
disp(reshape(v,4,4))
disp("vk+1 : ")
disp(reshape(V,4,4))
for k =1:1:3
    
    % 시행횟수 k==1에서는 현재 가치함수를 임의의 값으로 초기화 (단, 종단상태에서의 값은 0으로)
    if k==1
        v=-ones(16,1);
        %종단 상태에서의 가치함수 값
        v(1)=0;
        v(end)=0;
    end
    % 모든 상태 S에 대해서 loop
    for s = S
        % s==0 인 경우는 종단상태이므로 가치함수를 계산하지 않음.
        if s==0
            continue
        end
        % 가치함수는 (보상 + 할인율*이전 가치함수(다음상태)) 의 평균값이다.
        % value라는 임시 변수를 이용해 모두 더해서 평균을 구한다.        
        value = 0;
        for a = A
            next_s = next_state(s,a); % 행동 a 후의 s의 다음 상태 next_s
            r = get_reward(s,a); % 보상
            % 다음 가치함수의 값 = 다음 가치함수의 값 + (보상 + 할인율*이전 가치함수(다음상태))/(행동 갯수)
            value=value+(r+gamma*v(next_s+1))/length(A);
        end
        V(s+1) = round(value,2);
%         disp(string(s)+":"+string(V(s+1)))
    end

    disp("----------------------------k : "+string(k)+"----------------------------")
    disp("vk : ")
    disp(reshape(v,4,4))
    disp("vk+1 : ")
    disp(reshape(V,4,4))
    v = V;
end


%% functions 
function next_s =next_state(s,a)
%       0  1  2  3  
%       4  5  6  7
%       8  9  10 11
%       12 13 14 0
    up = 1;
    down = 2;
    right = 3;
    left = 4;
    
    %% 행동에 따른 다음 상태 정의
    
    if a ==up 
        if sum(s==[1 2 3])>=1
            next_s = s;        
        else
            next_s = s-4;
        end
        if s==4
            next_s  = 0;
        end
    elseif a==down
        if sum(s==[12 13 14])>=1
            next_s = s;       
        else
            next_s = s+4;
        end
        if s==11
            next_s  = 0;
        end
    elseif a==right 
        if sum(s==[3 7 11])>=1
            next_s = s;       
        else
            next_s = s+1;
        end
        if s==14
            next_s  = 0;
        end
    elseif a==left 
        if sum(s==[4 8 12])>=1
            next_s = s;       
        else
            next_s = s-1;
        end
        if s==1
            next_s  = 0;
        end
    end
 
end


function r =get_reward(s,a)
    r = -1;
end


function p =get_policy(policy,s,a)
    p = 0.25;
end





