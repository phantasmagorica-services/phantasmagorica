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

	/// full list of subsystems that need ticking ; generated from subsystems without SS_NO_FIRE
	/// ticker must be rebooted to update this
	var/list/datum/controller/subsystem/ticking
	/// linkedlist head of subsystems that got paused and need to finish their tick asap
	var/datum/controller/subsystem/head_paused
	/// linkedlist head of subsystems that are waiting to run; does not include paused
	var/datum/controller/subsystem/head_pending

#warn impl

/datum/controller/ticker/proc/loop()
	#warn impl

/datum/controller/ticker/proc/set_runlevel(runlevel)
	#warn impl
