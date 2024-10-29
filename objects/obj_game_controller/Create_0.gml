// // obj_game_controller Create Event
// show_debug_message("Starting Game Controller Creation");

// // Check for existing instance first
// if (instance_number(obj_game_controller) > 1) {
//     show_debug_message("Duplicate controller found - destroying this instance");
//     instance_destroy();
//     exit;
// }

// // Flag to track if we've initialized
// initialized = false;

// // Initialize all basic variables
// persistent = true;
// game_active = false;
// timer_active = false;

// // Create fresh data structures
// try {
//     active_words = ds_map_create();
//     required_words = ds_map_create();
//     active_blocks = ds_list_create();
//     initialized = true;
//     show_debug_message("Data structures created successfully");
// } catch(error) {
//     show_debug_message("Error creating data structures: " + string(error));
//     exit;
// }

// // Game mode enum and variable
// enum GameMode {
//     CASUAL,
//     TIMED
// }
// game_mode = GameMode.CASUAL;

// // Initialize game position arrays
// block_x_positions_by_row_length = {
//     len4: [375, 465, 555, 645],
//     len5: [330, 420, 510, 600, 690],
//     len6: [285, 375, 465, 555, 645, 735],
//     len7: [240, 330, 420, 510, 600, 690, 780],
//     len8: [195, 285, 375, 465, 555, 645, 735, 825],
//     len9: [150, 240, 330, 420, 510, 600, 690, 780, 870],
//     len10: [195, 285, 375, 465, 555, 645, 735, 825, 915, 1005]
// };

// block_y_position_by_level = {
//     lev1: [375,465,555,645],
//     lev2: [330,420,510,600,690],
//     lev3: [285,375,465,555,645,735],
//     lev4: [240,330,420,510,600,690,780],
//     lev5: [195,285,375,465,555,645,735,825],
//     lev6: [150,240,330,420,510,600,690,780,870],
//     lev7: [195,285,375,465,555,645,735,825,915,1005]
// };

// // Game state variables
// current_level = 1;
// current_row_length = 4;
// current_word = "";
// active_blocks = ds_list_create();

// // Timer variables - initialize but don't start
// time_remaining = 180;
// timer_active = false;
// timer_format = "";

// // Scoring variables
// global.current_score = 0;
// level_bonus = 1000;
// time_bonus = 100;
// word_base_points = 100;
// combo_multiplier = 1;
// last_word_time = get_timer() / 1000000;
// combo_timeout = 5;

// max_level = 7; // Add this to define maximum level

// show_debug_message("Game Controller Creation Complete");