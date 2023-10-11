/**
 * Bitflags for /atom/var/atom_flags
 */

/// Initialized by atom initialization
#define ATOM_FLAG_INITIALIZED (1<<0)

DEFINE_BITFIELD(atom_flags, list(
	/atom = list(
		"atom_flags",
	),
), list(
	BITFIELD("Initialized", ATOM_FLAG_INITIALIZED),
))
