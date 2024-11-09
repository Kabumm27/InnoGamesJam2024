shader_type canvas_item;

uniform vec4 color : source_color;
uniform vec4 replace_color : source_color;
uniform float color_threshold : hint_range(0.0, 1.0, 0.001);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
	float color_distance = length(tex_color.rgb - color.rgb);

    if (color_distance < color_threshold) {
		tex_color = replace_color;
	}

	COLOR = tex_color;
}
