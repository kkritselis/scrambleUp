//// obj_game_controller Clean Up Event
//if (variable_instance_exists(id, "initialized") && initialized) {
//    show_debug_message("Starting Clean Up Event");
    
//    if (variable_instance_exists(id, "active_words") && ds_exists(active_words, ds_type_map)) {
//        ds_map_destroy(active_words);
//        show_debug_message("Destroyed active_words map");
//    }
    
//    if (variable_instance_exists(id, "required_words") && ds_exists(required_words, ds_type_map)) {
//        ds_map_destroy(required_words);
//        show_debug_message("Destroyed required_words map");
//    }
    
//    if (variable_instance_exists(id, "active_blocks") && ds_exists(active_blocks, ds_type_list)) {
//        ds_list_destroy(active_blocks);
//        show_debug_message("Destroyed active_blocks list");
//    }
    
//    initialized = false;
//    show_debug_message("Clean Up Complete");
//}

//show_debug_message("Room End - Cleaned up letters");