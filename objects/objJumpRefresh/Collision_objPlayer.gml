if (!visible) {
	exit;
}

other.jump_left = approach(other.jump_left, other.jump_total - 1, 1);
visible = false;
alarm[0] = refresh_frames;