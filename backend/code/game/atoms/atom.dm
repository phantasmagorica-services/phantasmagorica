/**
 * base type of all on-map objects in BYOND
 */
/atom
	abstract_type = /atom

	/// flags bitfield
	var/atom_flags = NONE

/atom/clone(x, y, z)
	CRASH("not implemented")
