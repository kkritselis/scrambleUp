function load_json_file(fileName) {
	
    var file = file_text_open_read(fileName); // No need for "datafiles/" prefix
    if (file == -1) {
        show_debug_message("Error: Could not open file '" + fileName + "'");
        return undefined;
    }
    
    var fileText = "";
    while (!file_text_eof(file)) {
        fileText += file_text_read_string(file);
        file_text_readln(file); // Move to next line
    }
    file_text_close(file);
    
    return json_parse(fileText);
}

