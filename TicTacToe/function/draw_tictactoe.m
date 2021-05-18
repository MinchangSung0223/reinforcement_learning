function draw_tictactoe(state,ret)
S = [state(1) state(2) state(3);state(4) state(5) state(6); state(7) state(8) state(9)];

if ret==0
plot([0 3 3 0 0],[0 0 3 3 0],'k-',"LineWidth",5)
hold on;
plot([1 1 2 2],[0 3 3 0],'k-',"LineWidth",5)
plot([0 3 3 0],[1 1 2 2],'k-',"LineWidth",5)
else
plot([0 3 3 0 0],[0 0 3 3 0],'b-',"LineWidth",5)
hold on;
plot([1 1 2 2],[0 3 3 0],'b-',"LineWidth",5)
plot([0 3 3 0],[1 1 2 2],'b-',"LineWidth",5)
    
end

for i=1:1:3
    for j=1:1:3
        %draw circle
        if S(i,j)==1
            draw_circle([j-0.5,(3-i+1)-0.5],0.4)
        elseif S(i,j)==-1
            draw_x([j-0.5,(3-i+1)-0.5],0.5)
        end
    end
end
axis([-1 4 -1 4])
daspect([1,1,1])
drawnow;
end
function draw_circle(p,r)
hold on;
th = linspace(0,2*pi,100);
x = r*cos(th)+p(1);
y = r*sin(th)+p(2);
plot(x,y,"r-","LineWidth",5);
end

function draw_x(p,r)
hold on;
plot([p(1)-r*cos(pi/4) p(1)+r*cos(pi/4);],[p(2)-r*sin(pi/4) p(2)+r*sin(pi/4);],"r-","LineWidth",5);
plot([p(1)+r*cos(pi/4) p(1)-r*cos(pi/4);],[p(2)-r*sin(pi/4) p(2)+r*sin(pi/4);],"r-","LineWidth",5);
end