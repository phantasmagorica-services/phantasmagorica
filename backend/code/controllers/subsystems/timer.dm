SUBSYSTEM_DEF(timer)
	name = "Timer"
	subsystem_flags = SS_TICKER
	interval = 1

	/// buckets of doubly-linked timers
	var/list/short_queue
	/// secondary queue - binary insert'd timers
	var/list/long_queue

	/// next timerid for stoppable timers
	var/static/next_timerid = 0
	/// stoppable timer dict
	var/list/timerid_dict = list()
	/// hash timer dict
	var/list/timerhash_dict = list()

/datum/controller/subsystem/timer/construct(rebuilding)
	short_queue = new /list(TIMER_SYSTEM_INTERVAL * 0.1 * world.fps)

/datum/controller/subsystem/timer/fire(resumed, deciseconds, times_fired)
	. = ..()
	#warn impl

/datum/controller/subsystem/timer/proc/rebuild_queues(list/datum/timer/timers_provided = all_timers())
	short_queue = new /list(TIMER_SYSTEM_INTERVAL * 0.1 * world.fps)
	long_queue = list()
	#warn impl

/datum/controller/subsystem/timer/proc/all_timers()
	var/list/datum/timer/found = list()
	for(var/datum/timer/timer in long_queue)
		found += timer
	if(islist(short_queue))
		for(var/i in 1 to length(short_queue))
			var/datum/timer/timer = short_queue[i]
			if(isnull(timer))
				continue
			var/datum/timer/head = timer
			do
				if(!istype(timer))
					break
				found += timer
				timer = timer.next
			while(timer != head)
	return found

/datum/controller/subsystem/timer/proc/rebuild_everything()
	var/list/datum/timer/timers = all_timers()
	timerid_dict = list()
	timerhash_dict = list()
	for(var/datum/timer/timer as anything in timers)
		if(istext(timer.id))
			timerid_dict[timer.id] = timer
		if(istext(timer.hash))
			timerhash_dict[timer.hash] = timer
	rebuild_queues(timers)

/datum/controller/subsystem/timer/recover()
	rebuild_everything()
	return SS_RECOVER_SUCCESS

/datum/controller/subsystem/timer/fps_changed(old_fps, new_fps)
	rebuild_queues()
