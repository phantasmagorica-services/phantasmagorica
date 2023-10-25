/**
 * merge 1-deep assoc lists; from_list overwrites into_list
 */
/proc/merge_assoc_list(list/into_list, list/from_list)
	. = into_list.Copy()
	for(var/key in from_list)
		.[key] = from_list[key]
