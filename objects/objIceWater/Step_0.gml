event_inherited();

if (object_index != objWeirdWater) {
	time += irandom_range(1, 10);

	if (time > 250) {
		instance_create_layer(x + irandom(sprite_width), y + irandom(sprite_height), layer, objIceWaterPart);
		time = 0;
	}
}