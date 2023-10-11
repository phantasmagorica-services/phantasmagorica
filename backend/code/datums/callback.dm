/datum/callback
	/// call target
	var/delegate
	/// proc ref to call on target
	var/procref
	/// arguments
	var/list/arguments

/datum/callback/New(delegate, procref, list/arguments)
	src.delegate = delegate
	src.procref = procref
	src.arguments = arguments

/**
 * Invokes in blocking mode
 *
 * Returns result of call
 */
/datum/callback/proc/invoke()
	if(delegate == GLOBAL_PROC)
		return call(procref)(arglist(arguments))
	else
		return call(delegate, procref)(arglist(arguments))

/**
 * Invokes in async mode
 *
 * Does not return result.
 */
/datum/callback/proc/invoke_async()
	set waitfor = FALSE
	invoke()
