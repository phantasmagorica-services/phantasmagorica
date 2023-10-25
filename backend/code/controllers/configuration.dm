/**
 * # Configuration controller
 */
CONTROLLER_DEF(configuration, Config)

#warn impl

/datum/controller/configuration/proc/load_config()
	var/backend_path_default = "config_default/backend.toml"
	var/backend_path_config = "config/backend.toml"
	var/content_path_default = "config_default/content.toml"
	var/content_path_config = "config/content.toml"

	var/list/backend_default = rustg_read_toml_file(backend_path_default)
	var/list/backend_config = rustg_read_toml_file(backend_path_config)
	var/list/content_default = rustg_read_toml_file(content_path_default)
	var/list/content_config = rustg_read_toml_file(content_path_config)

	var/list/config = awful_config_reducer(
		awful_config_reducer(
			backend_default,
			backend_config,
			"backend.toml",
		),
		awful_config_reducer(
			content_default,
			content_config,
			"content.toml",
		),
		"<merge>",
	)

	parse_config(config)

	#warn impl

/datum/controller/configuration/proc/load_admins()
	var/admin_path_default = "config_default/admin.toml"
	var/admin_path_config = "config/admin.toml"

	var/list/admin_defualt = rustg_read_toml_file(admin_path_default)
	var/list/admin_config = rustg_read_toml_file(admin_path_config)

	var/list/config = awful_admin_reducer(
		admin_default,
		admin_config,
		"admin.toml",
	)

	#warn impl

/**
 * works up to 2 deep, because you shouldn't be going beyond that anyways.
 */
/datum/controller/configuration/proc/awful_config_reducer(list/defaults, list/overrides, emit_for_filename)
	// we can just do a 2 level reducer
	var/list/output = list()
	for(var/section in defaults)
		if(!istext(section))
			if(!isnull(emit_for_filename))
				Logging.log_config("file [emit_for_filename] - non-text section [json_encode(section)] tripped on admin reducer")
			continue
		var/list/details = defaults[section]
		output[section] = islist(details)? details.Copy() : details
	for(var/section in overrides)
		if(!istext(section))
			if(!isnull(emit_for_filename))
				Logging.log_config("file [emit_for_filename] - non-text section [json_encode(section)] tripped on admin reducer")
			continue
		var/list/details = defaults[section]
		output[section] = islist(details)? merge_assoc_list(output[section], details) : details
	return output

/datum/controller/configuration/proc/awful_admin_reducer(list/defaults, list/overrideS, emit_for_filename)
	// we can just do a 2 level reducer
	// because it's just admin.ranks, and admin.ckeys
	// this is currently just a copy of config reducer but i wanted to be clear they're not necessarily always
	// going to forever be the same format
	var/list/output = list()
	for(var/section in defaults)
		if(!istext(section))
			if(!isnull(emit_for_filename))
				Logging.log_config("file [emit_for_filename] - non-text section [json_encode(section)] tripped on admin reducer")
			continue
		var/list/details = defaults[section]
		output[section] = islist(details)? details.Copy() : details
	for(var/section in overrides)
		if(!istext(section))
			if(!isnull(emit_for_filename))
				Logging.log_config("file [emit_for_filename] - non-text section [json_encode(section)] tripped on admin reducer")
			continue
		var/list/details = defaults[section]
		output[section] = islist(details)? merge_assoc_list(output[section], details) : details
	return output
