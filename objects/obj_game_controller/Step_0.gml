if (game_active && room == rm_game) {
    if (game_mode == GameMode.TIMED && timer_active) {
        if (time_remaining > 0) {
            time_remaining -= delta_time/1000000;
            
            // Format timer as MM:SS
            var minutes = floor(time_remaining/60);
            var seconds = floor(time_remaining mod 60);
            timer_format = string(minutes) + ":" + string_pad(seconds, 2, "0");
            
            if (time_remaining <= 30) {
                if (floor(time_remaining) mod 2 == 0) {
                    alarm[1] = 15;
                }
            }
        } else {
            time_remaining = 0;
            timer_format = "0:00";
            end_level(false);
        }
    }
}

// Helper function to pad numbers with leading zeros
function string_pad(num, total_digits, pad_char) {
    var str = string(num);
    while (string_length(str) < total_digits) {
        str = pad_char + str;
    }
    return str;
}