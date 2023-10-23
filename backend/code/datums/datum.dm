/**
 * base type of most objects in BYOND
 */
/datum
	/// abstract type - commonly used pattern of discerning a 'root' path that is only there to be a template
	/// and not to be used literally
	var/abstract_type = /datum
	/// active timer datums to clear on destroy
	var/list/datum/timer/timers
	/// tracks time we were deleted, or contains an enum
	var/gc_destroyed
	/// datum signals: signal --> list of datums associated to procrefs to call
	var/list/signal_lookup
	/// datum signals: datum --> list of signals we registered on them
	var/list/signal_outgoing

	#warn hook

/**
 * clone
 */
/datum/proc/clone()
	CRASH("not implemented")

/**
 * called when we're being deleted
 */
/datum/Destroy()
	QDEL_LIST(timers)
	clear_signals()
	return QDEL_HINT_QUEUE

/datum/proc/register_signal(datum/target, signal, procref)
	#warn impl

/datum/proc/unregister_signal(datum/target, signal)
	#warn impl

/datum/proc/clear_signals()
	for(var/datum/D as anything in signal_outgoing)
		for(var/signal in signal_outgoing[D])
			unregister_signal(D, signal)
	for(var/signal in signal_lookup)
		for(var/datum/D as anything in signal_lookup[signal])
			D.unregister_signal(src, signal)

/datum/proc/__raise_signal(signal, ...)
	. = NONE
	#warn impl

/**
 * do we count as containing someone? used for UIs and other checks
 */
/datum/proc/contains(mob/user)
	return FALSE
