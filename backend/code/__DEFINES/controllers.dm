//* Controller definition helpers

#define CONTROLLER_DEF(NAME, VARNAME) \
var/global/datum/controller/##NAME/##VARNAME; \
/datum/controller/##NAME

#define SUBSYSTEM_DEF(NAME) \
var/global/datum/controller/subsystem/##NAME/SS##NAME; \
/datum/controller/subsystem/##NAME

#define REPOSITORY_DEF(NAME) \
var/global/datum/controller/repository/##NAME/RS##NAME; \
/datum/controller/repository/##NAME

#define ENTITYMAP_DEF(NAME) \
var/global/datum/controller/entitymap/##NAME/ES##NAME; \
/datum/controller/entitymap/##NAME

#warn impl

//* /datum/controller/subsystem/var/subsystem_flags

/// interval measured in ticks, has higher priority bracket than normal
#define SS_TICKER (1<<0)
/// has lower priority bracket than normal
#define SS_BACKGROUND (1<<1)
/// does not fire
#define SS_NO_FIRE (1<<2)
/// does not initialize
#define SS_NO_INIT (1<<3)

DEFINE_BITFIELD(subsystem_flags, list(
	/datum/controller/subsystem = list(
		"subsystem_flags",
	),
), list(
	BITFIELD("Ticker", SS_TICKER),
	BITFIELD("Background", SS_BACKGROUND),
	BITFIELD("No Fire", SS_NO_FIRE),
	BITFIELD("No Init", SS_NO_INIT),
))

//* /datum/controller/subsystem/var/runlevels

/// run during init
#define SS_RUNLEVEL_INIT (1<<0)
/// run during game simulation
#define SS_RUNLEVEL_GAME (1<<1)

DEFINE_BITFIELD(subsystem_runlevels, list(
	/datum/controller/subsystem = list(
		"runlevels",
	),
), list(
	BITFIELD("Init", SS_RUNLEVEL_INIT),
	BITFIELD("Main", SS_RUNLEVEL_GAME),
))

//* Subsystem init priorities - lower is higher

#define INIT_PRIORITY_DEFAULT 0

//* Subsystem tick priorities - higher is higher

//? TICKER SUBSYSTEMS ?//

// none yet

//? NORMAL SUBSYSTEMS ?//

#define FIRE_PRIORITY_DEFAULT 0

//? BACKGROUND SUBSYSTEMS ?//

// none yet
