/**
 * extract typepath into parts
 *
 * * WARNING - this assumes parent_type abuse is not going on.
 */
/proc/explode_typepath(path)
	ASSERT(ispath(path))
	path = "[path]"
	var/list/split = splittext(path, "/")
	if(!length(split))
		return
	// cut off first as it's an empty string from the leading /
	split.Cut(1, 2)
	return split

/**
 * subtypes of path
 */
/proc/subtypesof(path)
	return typesof(path) - path

/**
 * return nth level types of path; EXPENSIVE.
 *
 * depth = 0 means the path itself.
 * depth = 1 means immediate typepaths.
 * depth = 2 means typepaths after that.
 *
 * so on, so forth.
 */
/proc/subtypes_of_depth(path, depth)
	. = list()
	depth = depth + length(explode_typepath(path))
	for(var/sub in typesof(path))
		var/list/potential = explode_typepath(sub)
		if(length(potential) != depth)
			continue
		. += sub

/**
 * return non abstract subtypes
 */
/proc/non_abstract_typesof(path)
	. = list()
	for(var/datum/scan as anything in typesof(path))
		if(initial(scan.abstract_type) == scan)
			continue
		. += scan
