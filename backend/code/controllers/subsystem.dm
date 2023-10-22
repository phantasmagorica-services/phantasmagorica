/datum/controller/subsystem
	name = "Subsystem"

	//* subsystem intrinsics
	/// flags
	var/subsystem_flags = NONE
	/// interval in deciseconds
	var/interval = 1 SECONDS
	/// are we initialized? even SS_NO_INIT will have this set, they just won't proc Initialize()
	var/initialized = SS_INIT_NOT_STARTED
	/// fire priority
	var/fire_priority = FIRE_PRIORITY_DEFAULT
	/// init order
	var/init_order = INIT_ORDER_DEFAULT
	/// can fire? set to FALSE to block firing. unlike SS_NO_FIRE, this is able to be modified on the fly, rather than being permanent.
	var/can_fire = TRUE
	/// when do we run?
	var/runlevels = SS_RUNLEVEL_GAME

	//* tick tracking
	/// times fired
	var/times_fired = 0
	/// last world.time fired
	var/last_fire = 0
	/// next world.time to fire
	var/next_fire = 0
	#warn ughhh the above is fucked; make sure to reset them in loop start

	//* internal ticker system
	/// prev subsystem in linked list of processing queue
	var/datum/controller/subsystem/queue_prev
	/// next subsystem in linked list of processing queue
	var/datum/controller/subsystem/queue_next

#warn today i build a process scheduler

/**
 * initialize at server boot
 */
/datum/controller/subsystem/proc/initialize()
	return SS_INIT_SUCCESS

/**
 * teardown at server shutdown
 */
/datum/controller/subsystem/proc/shutdown()
	return SS_SHUTDOWN_SUCCESS

/**
 * called as we're created
 *
 * do not put expensive code in here
 *
 * @params
 * * rebuilding - are we recover()ing midrun?
 */
/datum/controller/subsystem/proc/construct(rebuilding)
	#warn hook

/**
 * recover
 *
 * the global variable we're in is still set to the old instance, if applicable
 */
/datum/controller/subsystem/proc/recover()
	return SS_RECOVER_IGNORED

/**
 * called to fire by ticker
 */
/datum/controller/subsystem/proc/ignite()
	#warn impl

/**
 * called to do its work
 */
/datum/controller/subsystem/proc/fire(resumed, deciseconds, times_fired)
	subsystem_flags |= SS_NO_FIRE
	can_fire = FALSE
	CRASH("base of fire() reached; please mark this subsystem with SS_NO_FIRE since it clearly isn't doing anything.")

/**
 * called to suspend for a number of ticks
 */
/datum/controller/subsystem/proc/suspend(ticks)
	#warn impl

/**
 * called to pause when we've run out of tick
 */
/datum/controller/subsystem/proc/pause()
	#warn impl
	return TRUE

/**
 * called when world.fps changes
 */
/datum/controller/subsystem/proc/fps_changed(old_fps, new_fps)
	return
