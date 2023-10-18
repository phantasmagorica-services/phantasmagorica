/**
 * # System controller
 *
 * Manages startup, shutdown, handles everything
 */
CONTROLLER_DEF(system, System)
	name = "System"

	/// repositories
	var/list/datum/controller/repository/repositories = list()
	/// subsystems
	var/list/datum/controller/subsystem/subsystems = list()
	/// entity mappers
	var/list/datum/controller/entitymap/entitymaps = list()

#warn impl

/datum/controller/system/New()
	if(isnull(GLOB))
		GLOB = new

	#warn impl

/datum/controller/system/proc/initialize(delay = 5 SECONDS)
	sleep(delay)
	init_announce_notice("-- system: startup --")
	#warn config
	#warn database
	init_announce_notice("-- system: start ticker --")
	world.reboot_ticker(SS_RUNLEVEL_INIT)
	init_announce_notice("-- system: start watchdog --")
	world.reboot_watchdog()
	init_announce_notice("-- system: initializing subsystems --")
	sort_list(subsystems, /proc/cmp_subsystem_init_order)
	for(var/datum/controller/subsystem/subsystem as anything in subsystems)
		if(!istype(subsystem))
			init_announce_fatal("-- system: unknown subsystem kicked out of init queue, what the hell just happened? --")
			subsystems -= subsystem
			continue
		var/start_time = REAL_TIME
		subsystem.initialized = SS_INIT_IN_PROGRESS
		var/result = subsystem.initialize()
		var/end_time = REAL_TIME
		var/time_render = "~[round(end_time - start_time, 0.1) * 0.1] seconds"
		switch(result)
			if(SS_INIT_SUCCESS)
				init_announce_notice("-- system: [subsystem] initializations finished in [time_render]!")
			if(SS_INIT_FAILED)
				init_announce_fatal("-- system: [subsystem] initialization failed after [time_render]! --")
		subsystem.initialized = SS_INIT_FINISHED
	init_announce_notice("-- system: game ready --")
	Ticker.set_runlevel(SS_RUNLEVEL_GAME)

/datum/controller/system/proc/shutdown()
	#warn impl

	sort_list(subsystems, /proc/cmp_subsystem_shutdown_order)

/datum/controller/system/proc/set_fps(fps)
	fps = clamp(fps, 1, 100)
	var/old = world.fps
	world.fps = fps
	for(var/datum/controller/subsystem/subsystem in subsystems)
		subsystem.fps_changed(old, fps)

