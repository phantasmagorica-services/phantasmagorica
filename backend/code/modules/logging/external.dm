//* Raw Message Logging *//

/**
 * authentication / authorization / connect / disconnect logs
 */
/datum/controller/logging/proc/to_access_log(msg)

/datum/controller/logging/proc/to_admin_log(msg)
	#warn impl

/datum/controller/logging/proc/to_asset_log(msg)
	#warn impl

/datum/controller/logging/proc/to_config_log(msg)
	#warn impl

/datum/controller/logging/proc/to_inventory_log(msg)
	#warn impl

/**
 * mechanical combat logging
 */
/datum/controller/logging/proc/to_mechanics_log(msg)
	#warn impl

/datum/controller/logging/proc/to_misc_log(msg)
	#warn impl

/**
 * rp & rp combat logging
 */
/datum/controller/logging/proc/to_roleplay_log(msg)
	#warn impl

/datum/controller/logging/proc/to_tgui_log(msg)
	#warn impl

//* Managed Logging Procs *//

/datum/controller/logging/proc/log_config(msg)
	to_config_log(msg)

/**
 * Appends a tgui-related log entry.
 * All arguments are optional.
 *
 * This function is stolen from /tg/station's TGUI client code, which is licensed under MIT.
 */
/datum/controller/logging/proc/log_tgui(user, message, context,
		datum/tgui_window/window,
		datum/src_object)
	var/entry = ""
	// Insert user info
	if(!user)
		entry += "<nobody>"
	else if(istype(user, /mob))
		var/mob/mob = user
		entry += "[mob.ckey] (as [mob] at [mob.x],[mob.y],[mob.z])"
	else if(istype(user, /client))
		var/client/client = user
		entry += "[client.ckey]"
	// Insert context
	if(context)
		entry += " in [context]"
	else if(window)
		entry += " in [window.id]"
	// Resolve src_object
	if(!src_object && window && window.locked_by)
		src_object = window.locked_by.src_object
	// Insert src_object info
	if(src_object)
		entry += "\nUsing: [src_object.type] [REF(src_object)]"
	// Insert message
	if(message)
		entry += "\n[message]"
	to_tgui_log(entry)
