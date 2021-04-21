clc;
clear;
close all;

A = 1;
B = 2;
S = [A,B];
Episodes={[A,3,A,2,B,-4,A,+4,B,-3];...
          [B,-2,A,+3,B,-3]
          };



%% Bellman 
gamma = 1;

V(A)= 0;
V(B)= 0;
Return{A} = [];
Return{B} = [];
for i = 1:1:length(Episodes)
    episode = Episodes{i};
    S=episode(1:2:end-1);
    R=episode(2:2:end);
    G = 0;
    str_S="";
    for s=S
        if s==A
            str_S = strcat(str_S," ","A");
        else
            str_S = strcat(str_S," ","B");
        end
    end
    disp("====================EPISODE "+string(i)+", S = "+str_S+", R = "+num2str(R)+"  ======================")
    for t =length(S):-1:1
        s = S(t);
        r = R(t);
        Return{s} = [Return{s},r];
        if s==A            
            disp("state : "+"A"+"   Return A : "+num2str(Return{A})+"  Return B : "+num2str(Return{B}))
        else
            disp("state : "+"B"+"   Return A : "+num2str(Return{A})+"  Return B : "+num2str(Return{B}))
        end
    end
    
end
V(A) = mean(Return{A});
V(B) = mean(Return{B});

disp("final:    V(A) : "+string(V(A))+"   V(B) : "+string(V(B))) 
