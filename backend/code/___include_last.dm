/// THIS FILE MUST BE BOTTOM OF .DME COMPILE ORDER ///

//* WARNING: DRAGONS AHEAD *//
/// This is where we make sure /datum/server_initialization runs first.

/datum/__boot_delegate

/datum/__boot_delegate/proc/execute()
	global.Initialization = new
	global.Initialization.Boot()


/proc/__boot_delegate()
	var/static/datum/__boot_delegate/delegate = new
	delegate.execute()
