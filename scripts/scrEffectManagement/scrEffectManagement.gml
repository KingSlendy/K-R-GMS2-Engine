function make_particles(type) {
	switch(type) {
		case "vines":
		global.partsys_vines = part_system_create();
		part_system_depth(global.partsys_vines, -100);

		//low-gravity
		global.part_lowgrav = part_type_create();
		part_type_shape(global.part_lowgrav, pt_shape_spark);
		part_type_color2(global.part_lowgrav, 16711808, 8388672);
		part_type_alpha2(global.part_lowgrav, 0.9492, 0.9222);
		part_type_life(global.part_lowgrav, 20.0000, 30.0000);
		part_type_size(global.part_lowgrav, 0.1907, 0.2147, 0.0010, 0.0124);
		part_type_speed(global.part_lowgrav, 2.8002, 3.1302, -0.0693, -0.1858);
		part_type_direction(global.part_lowgrav, 0.0000, 360.0000, 0.0000, 0.3559);
		part_type_orientation(global.part_lowgrav, 0.0000, 360.0000, -0.7222, 2.4790,0);
		part_type_gravity(global.part_lowgrav, 0.0000, 270.0000);
		part_type_blend(global.part_lowgrav, true);
		break;
	}
}