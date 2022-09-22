image_xscale = scale;
image_yscale = scale;
scale += 0.04;

image_alpha = approach(image_alpha, 0, 0.02);
if (image_alpha == 0) {
    instance_destroy();
}