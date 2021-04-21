clc;
clear;
close all;
A = 1;
B = 2;
S = [A,B];
Episodes={[A,3,A,2,B,-4,A,+4,B,-3];...
          [B,-2,A,+3,B,-3]
          };
%% First Visit Montecalro Mothod
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
        r = R(t); % 사실은 보상은 한 시점 뒤라서 Rt+1이지만 코드 상으로만 Rt
        G = gamma*G+r;
        findS=false;
        for tt = t-1:-1:1
            if s == S(tt)
                findS = true;
                continue;
            end
        end
        if findS == false
            Return{s} =[Return{s},G];
            V(s) = mean(Return{s});
        end
        RA = string(Return{A});
        str_RA="";
        for kk=1:1:length(RA)
            str_RA = strcat(str_RA,RA(kk),",");
        end
        RB = string(Return{B});
        str_RB="";
        for kk=1:1:length(RB)
            str_RB = strcat(str_RB,RB(kk),",");
        end
        disp("state : "+string(s)+"  G : "+string(G)+"  Return A : "+str_RA+"   Return B : "+str_RB) 
    end
end
disp("final:    V(A) : "+string(V(A))+"   V(B) : "+string(V(B))) 
