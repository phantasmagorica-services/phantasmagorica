/proc/addtimer(datum/callback/callback, delay, flags)
	#warn impl

/proc/deltimer(timerid)
	qdel(SStimer.timerid_dict[timerid])

/proc/gettimer(timerid)
	return SStimer.timerid_dict[timerid]

/**
 * Scheduled callback
 */
/datum/timer
	/// callback
	var/datum/callback/callback
	/// world.time scheduled to run
	var/run_at
	/// original delay
	var/delay
	/// timer flags
	var/timer_flags
	/// numerical id, for stoppable timers
	var/id
	/// hash, for unique timers
	var/hash

	/// linkedlist - next
	var/datum/timer/next
	/// linkedlist - prev
	var/datum/timer/prev

/datum/timer/New(datum/callback/callback, delay, flags = NONE)
	src.delay = delay
	src.run_at = world.time + delay
	src.callback = callback
	src.timer_flags = flags

/datum/timer/Destroy()
	#warn eject from subsystem
	return ..()

#warn impl
