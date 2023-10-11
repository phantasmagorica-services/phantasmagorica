/proc/addtimer(datum/callback/callback, delay, flags)
	#warn impl

/proc/deltimer(timerid)
	#warn impl

/proc/gettimer(timerid)
	#warn impl

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

/datum/timer/New(datum/callback/callback, delay, flags = NONE)
	src.delay = delay
	src.run_at = world.time + delay
	src.callback = callback
	src.timer_flags = flags

#warn impl
