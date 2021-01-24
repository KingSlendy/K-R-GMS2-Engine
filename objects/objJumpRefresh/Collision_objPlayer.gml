if (visible) {
	other.jump_left = clamp(other.jump_left++, 0, other.jump_total);
	visible = false;
	alarm[0] = refresh_frames;
}