/**
 * Bitflags for /turf/var/turf_flags
 */

DEFINE_BITFLAGS(turf_flags, list(
	/turf,
), list(
	"turf_flags",
), list(
))

//* /turf_path_danger var on /turf
/// openspace, chasms, etc
#define TURF_PATH_DANGER_FALL (1<<0)
/// will just fucking obliterate you
#define TURF_PATH_DANGER_ANNIHILATION (1<<1)

DEFINE_BITFLAGS(turf_path_danger, list(
	/turf,
), list(
	"turf_path_danger",
), list(
	BITFLAG("Falling", TURF_PATH_DANGER_FALL),
	BITFLAG("Annihilation", TURF_PATH_DANGER_ANNIHILATION),
))
