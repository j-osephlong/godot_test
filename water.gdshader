shader_type canvas_item;

uniform sampler2D sim_tex;

uniform float phase = 0.2;
uniform float attenuation = 0.999;
uniform float deltaUV = 3.0;

void fragment() {
	vec2 uv = vec2(UV.x, 1.0 - UV.y);
	float dv = 1.0 / 512.0;
	float du = 1.0 / 512.0;
	vec3 duv = vec3(du, dv, 0) * deltaUV;

	vec3 c = texture(sim_tex, UV).rgb;

	float p = (2.0 * c.r - c.g + phase * (
		texture(sim_tex, UV - duv.zy).r +
		texture(sim_tex, UV + duv.zy).r +
		texture(sim_tex, UV - duv.xz).r +
		texture(sim_tex, UV + duv.xz).r - 4.0 * c.r)) * attenuation;
		
	COLOR = vec4(p, c.r, 0, 1);
}