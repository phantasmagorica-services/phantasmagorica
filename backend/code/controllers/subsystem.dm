/datum/controller/subsystem
	name = "Subsystem"
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
 * called to fire by ticker
 */
/datum/controller/subsystem/proc/ignite()
	#warn impl

/**
 * called to do its work
 */
/datum/controller/subsystem/proc/fire(dt, times_fired)
	subsystem_flags |= SS_NO_FIRE
	can_fire = FALSE
	CRASH("base of fire() reached; please mark this subsystem with SS_NO_FIRE since it clearly isn't doing anything.")
