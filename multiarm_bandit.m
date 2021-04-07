
clc;
clear;
close all;
%Define q*(a)
epsilon_list = [0.0 0.1 0.01]
for i = 1:1:length(epsilon_list)
epsilon = epsilon_list(i)
R_list = zeros(200,1000);
Q_list = zeros(200,1000);

    for n=1:200
        a= normrnd(0,1,[1,10]);  % 10 개의 레버에 대한 평균 보상을 결정
        Q= zeros(10,1000); % Value의 추정치를 초기화
        R = zeros(10,1000);
        N= zeros(10,1000);
        for t = 2:1:1000
            if rand()<1-epsilon
                [M,A] =max(Q(:,t-1)); % 1-epsilon의  경우에는 argmax(Q)
            else
                A = randi(10); % epsilon의  경우에는 random한 레버 선택 
            end
            R(A,t) = normrnd(a(A),1);%레버를 돌려서 특정한 평균의 보상을 획득
            N(A,t) = N(A,t) +1; 
            for i =1:10
                Q(i,t) = Q(i,t-1) +1/sum(N(i,:))*(R(i,t-1)-Q(i,t-1));
                if isnan(Q(i,t))
                    Q(i,t)=0;
                end
            end
        end
         % 그림용 데이터 저장
        R_list(n,:) = sum(R);
        Q_list(n,:) = sum(Q);

    end
    figure(1);
    plot(mean(R_list));
    hold on;
    figure(2);
    hold on;
    plot(mean(Q_list(:,2:end)))
end
