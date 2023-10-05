/**
 * abstract root of /turf
 */
/turf
	abstract_type = /turf

	//* Flags
	/// turf flags
	var/turf_flags = NONE

	//* Movement / Pathfinding
	/// Pathfinding cost
	var/path_weight = 1
	/// danger flags to avoid
	var/turf_path_danger = NONE
	/// pathfinding id - used to avoid needing a big closed list to iterate through every cycle of jps
	var/tmp/pathfinding_cycle
