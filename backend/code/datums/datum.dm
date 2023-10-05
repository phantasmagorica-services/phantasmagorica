/**
 * base type of most objects in BYOND
 */
/datum
	/// abstract type - commonly used pattern of discerning a 'root' path that is only there to be a template
	/// and not to be used literally
	var/abstract_type = /datum

/**
 * clone
 */
/datum/proc/clone()
	CRASH("not implemented")

/**
 * called when we're being deleted
 */
/datum/Destroy()
	#warn gc system
