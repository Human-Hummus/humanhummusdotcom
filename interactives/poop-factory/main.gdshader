shader_type canvas_item;

uniform float outerRadius : hint_range(0.0, 5.0) = 3.0;
uniform float MainAlpha : hint_range(0.0, 1.0) = 0.9;

void fragment() {
	float x = abs(UV.x-.5)*2.0;
	float y = abs(UV.y-.5)*2.0;
	float v = (sqrt((x*x)+(y*y))/1.5);
	COLOR = vec4(0,0,0,v*0.9);
}