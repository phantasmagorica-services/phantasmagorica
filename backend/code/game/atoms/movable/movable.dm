/**
 * base type of /atom/movable, which are all objects in BYOND that can be in an arbitrary location
 */
/atom/movable
	abstract_type = /atom/movable

/atom/movable/clone(atom/newloc)
	CRASH("not implemented")

/**
 * Stores full state, not just base state
 *
 * This is on /movable level because /atom requires better handling than this by far.
 */
/atom/movable/proc/entity_serialize()
	RETURN_TYPE(/list)
	. = list()
	/// store core data like perks, etc
	.["core"] = serialize()

/**
 * Restores full state, not just base state
 *
 * This is on /movable level because /atom requires better handling than this by far.
 */
/atom/movable/proc/entity_deserialize(list/data)
	/// restore core data like perks, etc
	if(islist(data["core"]))
		deserialize(data["core"])
