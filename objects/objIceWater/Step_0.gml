event_inherited();

if (object_index != objWeirdWater) {
	time += irandom_range(1, 10);

	if (time > 250) {
		instance_create_depth(x + irandom(sprite_width), y + irandom(sprite_height), depth-1, objIceWaterPart);
		time = 0;
	}
}