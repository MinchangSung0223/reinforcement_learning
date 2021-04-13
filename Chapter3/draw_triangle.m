function draw_triangle(x,y)
th = linspace(0,2*pi,100);
r = 0.8;
x = [x*2+1-r x*2+1 x*2+1+r x*2+1-r ];
y = [(4-y)*2+1-r/2*sqrt(3)/3 (4-y)*2+1+r/2*sqrt(3)*3/2 (4-y)*2+1-r/2*sqrt(3)/3 (4-y)*2+1-r/2*sqrt(3)/3];
plot(x,y-0.3,'b-',"LineWidth",3);
end