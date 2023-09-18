shader_type canvas_item;

uniform float dissolve_state: hint_range(0.0, 1.0) = 0.0;
uniform sampler2D noise;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	float noise_value = texture(noise, UV).r;
	COLOR = texture_color;
	float dissolve_diff = abs(noise_value - dissolve_state);
	COLOR.rgb -= vec3(0.0, 0.0, 1.0) * step(dissolve_diff, dissolve_state);
	COLOR.a *= step(dissolve_state, noise_value);
}


