//// obj_game_controller Destroy Event
//if (variable_instance_exists(id, "initialized") && initialized) {
//    show_debug_message("Starting Destroy Event");
    
//    if (variable_instance_exists(id, "active_words") && ds_exists(active_words, ds_type_map)) {
//        ds_map_destroy(active_words);
//        show_debug_message("Destroyed active_words map in destroy");
//    }
    
//    if (variable_instance_exists(id, "required_words") && ds_exists(required_words, ds_type_map)) {
//        ds_map_destroy(required_words);
//        show_debug_message("Destroyed required_words map in destroy");
//    }
    
//    if (variable_instance_exists(id, "active_blocks") && ds_exists(active_blocks, ds_type_list)) {
//        ds_list_destroy(active_blocks);
//        show_debug_message("Destroyed active_blocks list in destroy");
//    }
    
//    initialized = false;
//    show_debug_message("Destroy Event Complete");
//}