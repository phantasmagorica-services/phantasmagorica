/**
 * a perk a character can have
 */
/datum/prototype/character_perk
	/// name
	var/name = "A perk"
	#warn icon system
	/// a stat modifier to give someone while they have us
	/// set to typepath to init
	/// this is a shared reference, and any characters with us share this modifier.
	#warn impl
	var/datum/character_stats/stat_modifier

#warn impl
#warn impl prototype
