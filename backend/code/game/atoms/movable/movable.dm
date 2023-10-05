/**
 * base type of /atom/movable, which are all objects in BYOND that can be in an arbitrary location
 */
/atom/movable
	abstract_type = /atom/movable

/atom/movable/clone(atom/newloc)
	CRASH("not implemented")
