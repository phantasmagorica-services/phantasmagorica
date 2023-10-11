h//* timer flags

/// we should return a timerid so it can be stopped via deltimer
#define TIMER_FLAG_STOPPABLE (1<<0)

DEFINE_BITFIELD(timer_flags, list(
	/datum/timer = list(
		"timer_flags",
	),
), list(
	BITFIELD("Stoppable", TIMER_FLAG_STOPPABLE),
))
