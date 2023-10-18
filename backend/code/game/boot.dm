/**
 * Server bootup happens like this:
 *
 * * 1. /datum/server_initialization is ran by the boot delegate that's defined last - this brings up the auxtools debugger first-thing
 * * 2. all /static variables in procs and prototypes (type variables) init in reverse order of compile
 * * 3. all /global variables in global scope init in order of compile
 * * 4. the System service is created as part of that - it should be the only real global that inits in this way
 * * 5. during New(), the System service creates the Configuration service, and the managed GLOB service
 * * 6. the managed GLOB service inits managed globals as part of this during its New()
 * * 7. the System service creates the Database service and attempts to connect it
 * * 8. the System service, still in New(), creates all subsystems
 * * 9. each subsystem being created calls their own PreInit()
 * * 10. repositories and entity mappers are created and linked to their databases as necessary from the Configuration service
 * * 11. the compiled in map is created, New() is called as necessary on everything
 * * 12. /world/New() runs and schedules the System service's initialization
 * * 13. the System service initialize()s, booting up the Ticker, Watchdog, and then initializing all Subsystems
 * * 14. the System service finalizes initialization and readies the world for joining
 *
 * how we hook ourselves to run first is by defining __boot_delegate as a static last in the compile order.
 */

/// real global
GLOBAL_REAL_DATUM(Initialization, /datum/server_initialization)

/**
 * Holds server boot data
 */
/datum/server_initialization

/datum/server_initialization/proc/Boot()
	first_thing_to_run()

/**
 * This runs before **anything** else.
 */
/datum/server_initialization/proc/first_thing_to_run()
	/// enable auxtools debugging
	var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if (debug_server)
		DYLIB_CALL(debug_server, "auxtools_init")()
		enable_debugging()
