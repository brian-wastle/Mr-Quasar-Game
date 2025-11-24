///@param x1
///@param y1
///@param w1
///@param x2
///@param y2
///@param w2
///@param color

function drawPolygon(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
var x1 = argument0; //0
var y1 = argument1; //screen_y
var w2 = argument2; //width of screen
var x2 = argument3; //0
var y2 = argument4; //screen_y
var w1 = argument5; //width of screen
var color = argument6;




draw_primitive_begin(pr_trianglelist);
    draw_vertex_color(x1+w2 , y1, color, 1);
    draw_vertex_color(x1-w2 , y1, color, 1);
    draw_vertex_color(x2-w1 , y2, color, 1);

draw_primitive_end();

draw_primitive_begin(pr_trianglelist);
    draw_vertex_color(x2+w1 , y2, color, 1);
    draw_vertex_color(x1+w2 , y1, color, 1);
    draw_vertex_color(x2-w1 , y2, color, 1);
draw_primitive_end();


}

