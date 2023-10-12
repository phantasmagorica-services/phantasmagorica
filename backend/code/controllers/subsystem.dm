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

#warn today i build a process scheduler
