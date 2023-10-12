/**
 * base type of all on-map objects in BYOND
 */
/atom
	abstract_type = /atom

	/// flags bitfield
	var/atom_flags = NONE

/**
 * Called to initialize the atom
 *
 * First argument is always 'mapload', which is set based on if this is part of a map loading operation.
 */
/atom/proc/Initialize(mapload)
	atom_flags |= ATOM_FLAG_INITIALIZED
	#warn initialization

/atom/clone(x, y, z)
	CRASH("not implemented")

/atom/contains(mob/user)
	return user in contents
