function parseMarkup(_text) {
    var outList = ds_list_create();
    var currentColor = c_black;
    var currentText = "";

    var i = 1;
    while (i <= string_length(_text)) {
        var c = string_char_at(_text, i);

        if (c == "{") {
            // Find the matching }
            var endPos = 0;
            for (var j = i + 1; j <= string_length(_text); j++) {
                if (string_char_at(_text, j) == "}") {
                    endPos = j;
                    break;
                }
            }

            if (endPos > 0) {
                var tag = string_copy(_text, i + 1, endPos - i - 1);

                if (string_length(currentText) > 0) {
                    var seg = ds_map_create();
                    ds_map_add(seg, "text", currentText);
                    ds_map_add(seg, "color", currentColor);
                    ds_list_add(outList, seg);
                    currentText = "";
                }

                switch (tag) {
                    case "r": currentColor = c_red; break;
                    case "/r": currentColor = c_black; break;
                }

                i = endPos + 1;
                continue;
            }
        }

        currentText += c;
        i += 1;
    }

    if (string_length(currentText) > 0) {
        var seg = ds_map_create();
        ds_map_add(seg, "text", currentText);
        ds_map_add(seg, "color", currentColor);
        ds_list_add(outList, seg);
    }

    return outList;
}