/**
 * Bitflags for /atom/var/atom_flags
 */

/// Initialized by atom initialization
#define ATOM_FLAG_INITIALIZED (1<<0)

DEFINE_BITFLAGS(atom_flags, list(
	/atom,
), list(
	"atom_flags",
), list(
	BITFLAG("Initialized", ATOM_FLAG_INITIALIZED),
))
