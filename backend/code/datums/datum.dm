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
	#warn gc system
	#warn clear timers
	#warn clear signals
	return QDEL_HINT_QUEUE

/datum/proc/register_signal(datum/target, signal, procref)
	#warn impl

/datum/proc/unregister_signal(datum/target, signal)
	#warn impl

/datum/proc/clear_signals()
	#warn impl

/datum/proc/__raise_signal(signal, ...)
	#warn impl
