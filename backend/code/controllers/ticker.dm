/world/proc/reboot_ticker(to_runlevel)
	#warn impl

	spawn(0)
		Ticker.loop()

/**
 * # Ticker
 */
CONTROLLER_DEF(ticker, Ticker)
	name = "Ticker"

	/// current cycle
	var/cycle = 0
	/// current runlevels
	var/runlevels = NONE

#warn impl

/datum/controller/ticker/proc/loop()
	#warn impl

/datum/controller/ticker/proc/set_runlevel(runlevel)
	#warn impl
