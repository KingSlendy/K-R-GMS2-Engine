function scrInstancePlaceList(xx, yy, obj){
	var dsid = ds_list_create();
	var this = id;
	var tangible = function(obj) { return (obj.image_alpha == 1); }

	with (obj) {
	    var that = id;
		
	    with (this) {
	        var i = instance_place_check(xx, yy, that, tangible);
			
	        if (i != -4) { 
				ds_list_add(dsid, i); 
			}
	    }
	}

	if (ds_list_empty(dsid)) {
	    ds_list_destroy(dsid);
	    dsid = -4;
	}

	return dsid;
}