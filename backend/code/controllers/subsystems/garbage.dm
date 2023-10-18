/**
 * Garbage collection subsystem
 *
 * Currently we use a very high wait time, as we expect deletions to be infrequent and people to not fuck up their ref clearing.
 */
SUBSYSTEM_DEF(garbage)
	name = "Garbage"
	interval = 10 SECONDS
	subsystem_flags = SS_BACKGROUND

	// fast, lockstep lists for queue and annihilation lists

	var/static/list/queue_refs = list()
	var/static/list/queue_times = list()
	var/static/list/annihilation_refs = list()
	var/static/list/annihilation_times = list()

	/// timeout before something's considered for annihilation
	var/hard_delete_timeout = 2 MINUTES
	/// ensure this many things are hard del'd before going back to queue
	var/annihilation_sweep_limit = 100
	/// if we complete a sweep with nothing to do, postpone for this much time
	var/empty_sweep_postpone = 30 SECONDS

	/// currently sweeping annihilation queues
	var/sweep_annihilation = FALSE
	/// current sweep index
	var/sweep_index

#warn recover should fully sweep queues

/datum/controller/subsystem/garbage/fire(resumed, deciseconds, times_fired)


/datum/controller/subsystem/garbage/proc/queue(datum/thing)
	thing.gc_destroyed = world.time
	queue_refs += ref(thing)
	queue_times += world.time

/proc/qdel(datum/thing)
	if(isnull(thing))
		// already gone
		return
	if(!istype(thing))
		// this will potentially throw a bad del error.
		del thing
		return

	if(!isnull(thing.gc_destroyed))
		SOFT_CRASH("[thing] ([thing.type]) attempted to qdel multiple times ([thing.gc_destroyed])")
		return

	// signal destruction
	RAISE_SIGNAL(thing, DSIG_DATUM_QDELETING)
	// call destroy
	thing.gc_destroyed = GC_IN_DESTROY
	var/start_time = world.time
	var/hint = thing.Destroy()
	var/slept = start_time != world.time

	if(slept)
		SOFT_CRASH("[thing] ([thing.type]) slept during Destroy()")
	// handle hint
	switch(hint)
		if(QDEL_HINT_FORBID)
			return
		if(QDEL_HINT_UNMANAGED)
			thing.gc_destroyed = world.time
			return
		if(QDEL_HINT_IMMEDIATE)
			// todo: this needs to have its runtime cost tracked when the subsystem gets its own harddels tracked
			del thing
			return
		if(QDEL_HINT_QUEUE)
			SSgarbage.queue(thing)
		else
			SOFT_CRASH("[thing] ([thing.type]) improper Destroy() return value: [hint]")
			SSgarbage.queue(thing)
