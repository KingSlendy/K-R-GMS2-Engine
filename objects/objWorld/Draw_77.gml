var windowWidth = window_get_width();
var windowHeight = window_get_height();

var aspectRatio = windowWidth / windowHeight;
var aspectRatioRatio = aspectRatio / (800 / 608);

var pixelScaling = (aspectRatioRatio < 1 && windowWidth % 800 != 0) || (aspectRatioRatio > 1 && windowHeight % 608 != 0) || (windowWidth % 800 != 0 && windowHeight % 608 != 0);

gpu_set_texrepeat(false);
gpu_set_blendenable(false);

if (pixelScaling) {
    gpu_set_texfilter(true);
    shader_set(shdPxUpscale);
}  

if (aspectRatioRatio < 1) {
    var canvasHeight = windowWidth * 608 / 800;
    var vertOutPixels = (windowHeight - canvasHeight) / 2;
    shader_set_uniform_f(u_texelsPerPixel, 800 / windowWidth, 608 / canvasHeight);
    draw_surface_stretched(application_surface, 0, vertOutPixels, windowWidth, canvasHeight);
} else {
    var canvasWidth = windowHeight * 800 / 608;
    var horOutPixels = (windowWidth - canvasWidth) / 2;
    shader_set_uniform_f(u_texelsPerPixel, 800 / canvasWidth, 608 / windowHeight);
    draw_surface_stretched(application_surface, horOutPixels, 0, canvasWidth, windowHeight);
}

if (pixelScaling) {
    shader_reset();
    gpu_set_texfilter(false);
}

gpu_set_blendenable(true);