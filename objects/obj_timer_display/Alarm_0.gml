/// @description Alarm[0]
// You can write your code in this editor
t_sec -= 1;

if t_sec = -1 {
	t_sec = 59;
	t_min -= 1;
}

if !(t_sec = 0 && t_min = 0) {
	alarm[0] = 60
} else {
	game_end()
}