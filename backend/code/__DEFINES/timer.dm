//* timer flags

/// we should return a timerid so it can be stopped via deltimer
#define TIMER_FLAG_STOPPABLE (1<<0)
/// hash to enforce uniqueness - by default, won't register if there's another one with the same target, procpath, and params
#define TIMER_FLAG_UNIQUE (1<<1)
/// use with unique - replace old timer rather than not run this one
#define TIMER_FLAG_OVERRIDE (1<<2)
/// also hash the wait param for uniqueness
#define TIMER_FLAG_HASH_WAIT (1<<3)

DEFINE_BITFIELD(timer_flags, list(
	/datum/timer = list(
		"timer_flags",
	),
), list(
	BITFIELD("Stoppable", TIMER_FLAG_STOPPABLE),
	BITFIELD("Unique", TIMER_FLAG_UNIQUE),
	BITFIELD("Override", TIMER_FLAG_OVERRIDE),
	BITFIELD("Hash Wait", TIMER_FLAG_HASH_WAIT),
))

//* system constants

/// we keep timers within this interval in main buckets
#define TIMER_SYSTEM_INTERVAL 2 MINUTES
