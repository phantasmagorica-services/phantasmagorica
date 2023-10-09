
#warn impl

/proc/qdel(datum/thing)
	if(!istype(thing))
		// this will potentially throw a bad del error.
		del thing
	#warn impl
