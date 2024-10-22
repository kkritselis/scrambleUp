/// @description draw the timer
// You can write your code in this editor
draw_set_color(c_black);
draw_set_font(fTimer);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

if (global.game_state == "timed") {
    draw_self();  // Draw the object if the state is "timed"
}

var t = "";
t+= string(t_min);
t+= ":";
if t_sec > 9 { t+= ""+string(t_sec)};
if t_sec < 10 { t+= "0"+string(t_sec)};

draw_text(1480,113,t)