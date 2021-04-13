function draw_box(x,y)
th = linspace(0,2*pi,100);
r = 0.7;
x = [x*2+1-r x*2+1+r x*2+1+r x*2+1-r  x*2+1-r ];
y = [(4-y)*2+1-r (4-y)*2+1-r (4-y)*2+1+r (4-y)*2+1+r (4-y)*2+1-r];
plot(x,y,'g-',"LineWidth",3);
end