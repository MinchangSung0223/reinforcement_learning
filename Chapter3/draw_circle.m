function draw_circle(x,y)
th = linspace(0,2*pi,100);
x = 0.8*cos(th)+x*2+1;
y = 0.8*sin(th)+(4-y)*2+1;
plot(x,y,'r-',"LineWidth",3);
end