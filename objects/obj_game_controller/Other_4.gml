// obj_game_controller Room Start Event
if (room == rm_game) {  // Only initialize when we enter the game room
    show_debug_message("Entering game room - initializing game");
    initialize_game();
}