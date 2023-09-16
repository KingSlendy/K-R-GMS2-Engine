if (image_alpha == 1 && platform == null) {
	instance_destroy(other);
	platform = instance_create_depth(x - 16, y - 32, depth, type);
}