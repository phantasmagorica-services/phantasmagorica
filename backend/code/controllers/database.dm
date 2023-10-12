/**
 * # Database
 */
CONTROLLER_DEF(database, Database)
	name = "Database"

#warn impl

/datum/controller/database/proc/is_connected()
	#warn impl

/**
 * attempts to ensure we are connected
 */
/datum/controller/database/proc/connect()
	#warn impl

/datum/controller/database/proc/disconnect()
	#warn impl

/datum/controller/database/proc/execute(sql, list/params, async = FALSE)
	#warn impl

/datum/controller/database/proc/query(sql)
	#warn impl

/datum/database_query
	/// currently running, don't run another
	var/running = FALSE
	/// was last run a success?
	var/succeeded
	/// last insert ID
	var/last_insert_id
	/// result rows - list of ordered lists
	var/list/rows
	/// affected row count
	var/affected
	#warn impl

/datum/database_query/Destroy()
	reset()
	return ..()

/datum/database_query/proc/execute(list/params, async = FALSE)
	#warn impl

/datum/database_query/proc/reset()
	succeeded = null
