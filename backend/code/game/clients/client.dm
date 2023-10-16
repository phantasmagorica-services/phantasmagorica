/// ckey-client association list
GLOBAL_LIST_EMPTY(client_lookup)
/// client list
GLOBAL_LIST_EMPTY(clients)
/**
 * /client, which represents players
 *
 * todo: better description of its pitfalls and nuances
 */
/client
	/// force /client to inherit from /datum
	parent_type = /datum
	/// manually calling Destroy from Del, gc should ignore us
	var/gc_client_deleting = FALSE

/client/New()
	#warn impl
	// register global
	GLOB.client_lookup[ckey] = src
	GLOB.clients += src
	// calls mob.Login()
	. = ..()

/client/Destroy()
	// unregister global
	GLOB.client_lookup -= ckey
	GLOB.clients -= src
	#warn impl
	..()
	return gc_client_deleting? QDEL_HINT_UNMANAGED : QDEL_HINT_IMMEDIATE

/client/Del()
	gc_client_deleting = TRUE
	// run cleanup
	if(isnull(gc_destroyed))
		qdel(src)
	return ..()

/**
 * returns if we are connecting from the host computer (or are launching the server directly in dreamseeker)
 */
/client/proc/is_localhost()
	return address in list(null, "127.0.0.1", "::1")
