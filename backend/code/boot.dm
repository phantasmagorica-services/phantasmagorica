/**
 * Server bootup happens like this:
 *
 * 1. /datum/server_initialization
 * 2. all /static variables in procs and prototypes (type variables) init
 * 3. all /global variables in global scope init
 * 4.
 */

/**
 * Holds server boot data
 */
/datum/server_initialization

/**
 * This runs before **anything** else.
 */
/datum/server_initialization/proc/first_thing_to_run()
	/// enable auxtools debugging
	var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if (debug_server)
		DYLIB_CALL(debug_server, "auxtools_init")()
		enable_debugging()
