/**
 * base type of server controller singleton datums
 */
/datum/controller
	abstract_type = /datum/controller

	/// name
	var/name = "Controller"

/**
 * announces init message
 */
/datum/controller/proc/init_announce_notice(msg)

/**
 * announces init issue
 */
/datum/controller/proc/init_announce_issue(msg)

/**
 * announces init fatal failure
 */
/datum/controller/proc/init_announce_fatal(msg)

/**
 * logs init message
 */
/datum/controller/proc/init_log_notice(msg)

/**
 * logs issue in init
 */
/datum/controller/proc/init_log_issue(msg)

/**
 * logs fatal failure in init
 */
/datum/controller/proc/init_log_fatal(msg)

#warn impl + log everything, including announces
