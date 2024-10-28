/// @description Insert description here
// You can write your code in this editor
sprite_index = sp_casual;
global.game_state = "casual";

var controller = instance_find(obj_game_controller, 0);
if (!controller) {
    controller = instance_create_layer(0, 0, "Instances", obj_game_controller);
}
with(controller) {
//art_casual_game();
}

room_goto(rm_game);