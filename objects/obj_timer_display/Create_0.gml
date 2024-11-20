/// @description setup timer
// You can write your code in this editor  global.game_state = "timed";
if (global.game_state == "timed") {
	show_debug_message("Timer time...");
    visible = true;  // Make the object visible
	t_min = 11;
	t_sec = 0;
	alarm[0] = 1;
} else {
    visible = false;  // Hide the object if the state is not "timed"
}