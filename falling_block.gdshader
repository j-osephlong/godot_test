shader_type spatial;

uniform float blend_value = 0;
uniform vec4 color : source_color;
uniform vec4 col_color : source_color;

uniform sampler2D noise;

uniform float noise_modifier = 1;

uniform vec3 center = vec3(0.0f);

void vertex() {
	float sample = texture(noise, UV  + TIME * 0.5).x;
	//VERTEX += (VERTEX - center) * (sample * noise_modifier);
	VERTEX = VERTEX + (sample * noise_modifier * (VERTEX - center) * blend_value);
}

void fragment() {
	ALBEDO = mix(color, col_color, blend_value).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
