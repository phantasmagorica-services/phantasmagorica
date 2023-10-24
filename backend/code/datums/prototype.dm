/**
 * datums that are storied in repositories
 *
 * these are read only once stored.
 */
/datum/prototype
	abstract_type = /datum/prototype

	/// Is this a custom prototype? If not, we just spawn by typepath.
	var/dynamic = TRUE

#warn impl - clone, id, etc
