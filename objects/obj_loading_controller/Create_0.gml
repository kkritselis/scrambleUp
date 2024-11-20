 if (!instance_exists(obj_game_controller)) {
     instance_create_layer(0, 0, "Instances", obj_game_controller);
     show_debug_message("Game Controller created in loading room");
 }

 global.data_loaded = false;

 // Start a small delay to ensure loading screen is drawn
 alarm[0] = 3;
