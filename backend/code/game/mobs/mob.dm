/**
 * base type of /mob, one of two movable types in BYOND
 * this is the only mob that players may inhabit
 */
/mob
	abstract_type = /mob

/mob/Initialize(mapload)
	#warn impl
	return ..()

/mob/Destroy()
	if(!isnull(client))
		evict_player()
	#warn impl
	return ..()

/**
 * Call to kick out any players in us
 *
 * client must be valid at this point!
 */
/mob/proc/evict_player()
	CRASH("attempted to evict a player on base /mob; why was a player even in base /mob?")
