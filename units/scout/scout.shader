shader_type canvas_item;

// Which color you want to change
uniform vec4 u_color_key : hint_color;
// Which color to replace it with
uniform vec4 u_replacement_color : hint_color;

void fragment() {
	// Get color from the sprite texture at the current pixel we are rendering
	vec4 col = texture(TEXTURE, UV);
//	// vec3 col = original_color.rgb;
//	if (original_color.rgb == u_color_key.rgb) {
//		COLOR = vec4(u_replacement_color.rgb, original_color.a);
//	} else {
//		COLOR = vec4(original_color.rgb, original_color.a);
//	}
	vec4 d4 = abs(col - u_color_key);
	float d = max(max(d4.r, d4.g), d4.b);
	if(d < 0.01) {
        col = u_replacement_color;
    }
    COLOR = col;
}