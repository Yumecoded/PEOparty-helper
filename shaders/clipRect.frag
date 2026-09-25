#pragma header
uniform vec4 uClipRect;

void main() {
    vec2 uv = openfl_TextureCoordv;
    vec2 px = uv * openfl_TextureSize;
    if (px.x < uClipRect.x || px.x > uClipRect.z ||
        px.y < uClipRect.y || px.y > uClipRect.w) {
        discard;
    }
    gl_FragColor = flixel_texture2D(bitmap, uv);
}
