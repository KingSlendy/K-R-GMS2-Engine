//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec2 u_texelsPerPixel;

void main()
{    
    vec2 locationInTexel = fract(v_vTexcoord);
    vec2 interp_amount = clamp(locationInTexel / u_texelsPerPixel, vec2(0.0), vec2(0.5, 0.5)) +
        clamp((locationInTexel - vec2(1.0, 1.0)) / u_texelsPerPixel + vec2(0.5, 0.5), vec2(0.0), vec2(0.5, 0.5));
    vec2 finalCoords = (floor(v_vTexcoord) + interp_amount) / vec2(800.0, 608.0);
    gl_FragColor = texture2D( gm_BaseTexture, finalCoords );
}