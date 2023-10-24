/**
 * base type of most objects in BYOND
 */
/datum
	//* Abstract Type
	/// abstract type - commonly used pattern of discerning a 'root' path that is only there to be a template
	/// and not to be used literally
	var/abstract_type = /datum

	//* Timers
	/// active timer datums to clear on destroy
	var/list/datum/timer/timers

	//* Garbage Collection
	/// tracks time we were deleted, or contains an enum
	var/gc_destroyed

	//* Datum Signals
	/// datum signals: signal --> list of datums associated to procrefs to call
	var/list/signal_lookup
	/// datum signals: datum --> list of signals we registered on them
	var/list/signal_outgoing

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

/**
 * Base serialization
 *
 * Used to store things required in reconstructing a datum from scratch, as if it was 'brand new' when used in
 * an object / entity context. This means mobs come out full HP with everything ready, etc etc.
 */
/datum/proc/serialize()
	RETURN_TYPE(/list)
	return list()

/**
 * todo: docs
 */
/datum/proc/deserialize(list/data)
	return
