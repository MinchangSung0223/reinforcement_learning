function draw_all(circle_position,triangle_position,box_position)
draw_board(1)
hold on;
for i =1:1:size(circle_position,1)
    draw_circle(circle_position(i,1),circle_position(i,2));
end
for i =1:1:size(triangle_position,1)
    draw_triangle(triangle_position(i,1),triangle_position(i,2));
end
for i =1:1:size(box_position,1)
    draw_box(box_position(i,1),box_position(i,2));
end
drawnow;
end