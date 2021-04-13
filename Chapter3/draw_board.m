function draw_board(text_draw)
for i =0:2:10
    plot([0 10],[i i],'k-');
    plot([i i],[0 10],'k-');
    hold on;
[X,Y] = meshgrid(0:1:4,0:1:4);
X = reshape(X,1,[]);
Y = reshape(Y,1,[]);
if text_draw==1
    for i = 1:1:length(X)
            text((X(i))*2+1,(4-Y(i))*2+1,string(X(i))+","+string(Y(i)));
    end
end

daspect([1,1,1]);
end