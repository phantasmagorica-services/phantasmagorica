/**
 * Comparators for use with sorts
 * They should return negative, zero, or positive numbers for a < b, a == b, and a > b respectively.
 */

//* Standard Sort*//

/**
 * the lazy man's low performance sort
 *
 * uses a datum's compare_to() proc.
 *
 * **Do not use this for any high performance context. It is slower than hardcoded comparators.
 *
 * **Warning: Only use this between to datums of the same logical type**. E.g. if you use one on another kinid of datum, you're going to get weird results,
 * because the compar procs are going to typecheck, and if it's not of the right type, you'll get unexpected results!
 */
/proc/cmp_auto_compare(datum/A, datum/B)
	if(istext(A) || istext(B))
		return cmp_text_asc("[A]", "[B]")
	return A.compare_to(B)

/**
 * standard datum comparison
 * no types are checked!
 *
 * **Do not use this for any high performance context. It is slower than hardcoded comparators.
 *
 * **Warning: Only use this between to datums of the same logical type**. E.g. if you use one on another kinid of datum, you're going to get weird results,
 * because the compar procs are going to typecheck, and if it's not of the right type, you'll get unexpected results!
 *
 * with the context of list index 1 = front,
 * return -1 for "I am infront of B" (list index closer to 1), 1 for "I am behind B" (list index further from 1), 0 for "I am equivalent to B"
 */
/datum/proc/compare_to(datum/D)
	return cmp_text_asc("[src]", "[D]")

//* Numbers *//

/proc/cmp_numeric_dsc(a,b)
	return b - a

/proc/cmp_numeric_asc(a,b)
	return a - b

//* Text *//

/proc/cmp_text_asc(a,b)
	return sorttext(b,a)

/proc/cmp_text_dsc(a,b)
	return sorttext(a,b)

//* Atoms *//

/proc/cmp_name_asc(atom/a, atom/b)
	return sorttext(b.name, a.name)

/proc/cmp_name_dsc(atom/a, atom/b)
	return sorttext(a.name, b.name)

//* Controllers *//

/proc/cmp_subsystem_init_order(datum/controller/subsystem/a, datum/controller/subsystem/b)
	return a.init_order - b.init_order

/proc/cmp_subsystem_shutdown_order(datum/controller/subsystem/a, datum/controller/subsystem/b)
	return b.init_order - a.init_order

/proc/cmp_subsystem_fire_priority(datum/controller/subsystem/a, datum/controller/subsystem/b)
	return b.fire_priority - a.fire_priority
