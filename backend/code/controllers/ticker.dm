/world/proc/reboot_ticker(to_runlevel)
	#warn impl

	spawn(0)
		Ticker.initiate()

/**
 * # Ticker
 */
CONTROLLER_DEF(ticker, Ticker)
	name = "Ticker"

	/// current cycle
	var/cycle = 0
	/// current runlevels
	var/runlevels = NONE
	/// exit and reload
	var/reload_on_next_cycle = FALSE

	/// full list of subsystems that need ticking ; generated from subsystems without SS_NO_FIRE
	/// ticker must be rebooted to update this
	var/list/datum/controller/subsystem/ticking

#define TICKER_LOOP_EXIT_INTENTIONAL "oops!"

/datum/controller/ticker/proc/initiate()
	ticking = list()
	for(var/datum/controller/subsystem/subsystem in System.subsystems)
		if(subsystem.subsystem_flags & SS_NO_FIRE)
			continue
		ticking += subsystem
	var/exit_status
	do
		// clear exit status
		exit_status = null
		// start loop
		exit_status = loop()
		// clear reload flag
		reload_on_next_cycle = FALSE
	while(exit_status == TICKER_LOOP_EXIT_INTENTIONAL)
	announce_fatal("-- ticker: loop unexpectedly exited with runlevels [runlevels]; attempting recovery --")
	world.reboot_ticker(runlevels)


/datum/controller/ticker/proc/loop()
	var/runlevels_cached = runlevels
	var/cycle_cached = cycle
	var/list/sorted_subsystems = ticking.Copy()
	for(var/datum/controller/subsystem/subsystem as anything in sorted_subsystems)
		subsystem.queue_next = null
		subsystem.queue_prev = null
		if(!(subsystem.runlevels & runlevels))
			sorted_subsystems -= subsystem
			continue
		#warn preprocess subsystems
	sort_list(sorted_subsystems, /proc/cmp_subsystem_fire_priority)
	do
		if(reload_on_next_cycle)
			announce_notice("-- ticker: reloading on request --")
			return TICKER_LOOP_EXIT_INTENTIONAL

		#warn do shit
		sleep(0)
	while(TRUE)

#undef TICKER_LOOP_EXIT_INTENTIONAL

/datum/controller/ticker/proc/set_runlevel(runlevel)
	src.runlevels = runlevel
	reload_on_next_cycle = TRUE
