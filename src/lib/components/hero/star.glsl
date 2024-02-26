#version 330 core

out vec4 FragColor;
in vec2 TexCoords;

uniform vec2 iResolution; // Viewport resolution (width, height)
uniform float iTime; // Time since the shader started

// Function to create a star-like pattern
float starPattern(vec2 p, float size) {
    p = p * size;
    float r = length(p);
    float a = atan(p.y, p.x);
    float pi = 3.1415926535897932384626433832795;
    float n = 6.0; // Number of branches
    float t = cos(floor(0.5 + a / (2.0 * pi / n)) * 2.0 * pi / n - a) * r;
    return smoothstep(0.3, 0.28, t) * pow(max(0.0, 1.0 - r), 0.25);
}

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;
    float size = 10.0; // Size of the pattern
    float pattern = starPattern(uv, size);

    // Background color
    vec3 bgColor = vec3(0.1, 0.2, 0.5);
    // Snowflake color
    vec3 sfColor = vec3(1.0, 1.0, 1.0);

    // Mix the snowflake color with the background based on the pattern
    vec3 color = mix(bgColor, sfColor, pattern);

    FragColor = vec4(color, 1.0);
}