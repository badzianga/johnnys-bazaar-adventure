shader_type canvas_item;

uniform float flash_state: hint_range(0.0, 1.0);

void fragment() {
	COLOR.gb = mix(COLOR.gb, vec2(0.0), flash_state);
}
