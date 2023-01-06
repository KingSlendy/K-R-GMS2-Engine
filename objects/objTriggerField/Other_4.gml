if (field == null) {
    exit;
}

var list = ds_list_create();
var count = instance_place_list(x, y, all, list, false);

for (var i = 0; i < count; i++) {
    with (list[| i]) {
		var func = method(id, other.field);
		func();
    }
}

ds_list_destroy(list);