clear;
S = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 , 0];

up = 1;
down = 2;
right = 3;
left = 4;
A = [up down right left] % up down right left
v = zeros(16,1);
p = [0.25 0.25 0.25 0.25];
policy = repmat(p,16,1)
V = zeros(16,1);

gamma = 1;
%       0  1  2  3  
%       4  5  6  7
%       8  9  10 11
%       12 13 14 0
k=0
disp("----------------------------k : "+string(k)+"----------------------------")
disp("vk : ")
disp(reshape(v,4,4))
disp("vk+1 : ")
disp(reshape(V,4,4))
for k =1:1:3
    if k==1
        v=-ones(16,1);
        v(1)=0;
        v(end)=0;
    end
    for s = S
        if s==0
            continue
        end
        value = 0;
        for a = A
            next_s = next_state(s,a);
            r = get_reward(s,a);
            value=value+(-1/4+0.25*gamma*v(next_s+1));
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
    next_s  = next_state(s,a);
    if next_s == 0
        r = 0;
    else
        r = -1;
    end
end


function p =get_policy(policy,s,a)
    p = 0.25;
end
