/world/proc/reboot_watchdog()
	if(!isnull(Watchdog))
		del Watchdog
	Watchdog = new
	spawn(0)
		Watchdog.loop()

/**
 * # Watchdog
 */
CONTROLLER_DEF(watchdog, Watchdog)
	name = "Watchdog"

	/// last ticker cycle
	var/ticker_cycle
	/// our cycle
	var/cycle = 0
	/// are we running?
	var/looping = FALSE

	/// how badly the ticker is fucked
	var/failure_ticks = 0
	/// we reboot ticker after this many ticks
	var/failure_limit = 5

/datum/controller/watchdog/proc/loop()
	if(looping)
		SOFT_CRASH("attempted to loop() while running")
		return
	// proc local cycle tracker
	var/cycle = src.cycle
	while(TRUE)
		if(cycle != src.cycle)
			SOFT_CRASH("loop() detected cycle mismatch - triggering rebuild")
			to_chat_immediate(world, type = CHAT_TYPE_SYSTEM, html = SPAN_SERVER_DANGER("-- fatal - watchdog loop cycle mismatch; attempting to recover... --"))
			// spawns will be killed by del()
			spawn(4 SECONDS)
				world.reboot_watchdog()
			return

		if(Ticker.cycle == src.ticker_cycle)
			++failure_ticks
			if(failure_ticks < failure_limit)
				to_chat_immediate(world, type = CHAT_TYPE_SYSTEM, html = SPAN_SERVER_DANGER("-- danger - watchdog ticker cycle tripped; [failure_limit - failure_ticks] trips to reboot... --"))
			else
				to_chat_immediate(world, type = CHAT_TYPE_SYSTEM, html = SPAN_SERVER_DANGER("-- fatal - watchdog ticker cycle tripped; rebooting... --"))
				failure_ticks = 0
				world.reboot_ticker()
				// todo: if ticker still isn't running, detect error state and halt
		else
			src.ticker_cycle = Ticker.cycle

		cycle = (src.cycle = (cycle + 1))
		sleep(2 SECONDS)

