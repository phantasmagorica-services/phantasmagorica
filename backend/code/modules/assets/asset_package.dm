/**
 * inspired by /tg/station's asset system
 *
 * registers browser assets
 *
 * these **must** be immutable once registered
 */
/datum/asset_package


#warn impl

/**
 * just a list of files to be sent
 */
/datum/asset_package/simple
	/// files
	var/list/files
	/// should be under one namespace
	var/is_namespaced = FALSE
	/// force namespace name - you usually want to set this for static / hardcoded packages
	/// otherwise, we hash the first file, or the primary file
	var/namespace

#warn impl
