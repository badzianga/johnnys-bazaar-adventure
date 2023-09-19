shader_type canvas_item;

uniform float flash_state: hint_range(0.0, 1.0);

//programatically change this if you want to, remove the progress based on time.
uniform float progress : hint_range(-1.0,2.0) = -0.4;
//the width of the burn area, higher values makes the burn wider, 1 makes the burn cover the whole sprite
uniform float width : hint_range(0.0,2.0) = .2;

//Noise to sample from for the burning
uniform sampler2D noise;
//colors to use for the burn color, the progress of the burn goes left to right
uniform sampler2D colorCurve;

//hacky way to make this angled, far from perfect. 1.0 is right to left. 0 is bottom to top. outside
//that range is wierd.
uniform float angle = 0.0;

float inverse_lerp(float a, float b, float v){
	return (v-a)/(b-a);
}

void fragment() {
	float burn_progress = progress;
	float noise_value = texture(noise,UV).x;
	float mask = inverse_lerp(1.0 - burn_progress,(1.0 + width) - burn_progress, (UV.x * angle + UV.y * (1.0-angle)));
	float value = clamp(mask + noise_value,0.0,1.0);
	vec4 curve_value = texture(colorCurve,vec2(value));
	COLOR = mix(COLOR, curve_value, value);
	COLOR.gb = mix(COLOR.gb, vec2(0.0), flash_state);
	COLOR.a = min(texture(TEXTURE,UV).a,COLOR.a);
}
