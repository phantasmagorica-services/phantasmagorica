/**
 *! Copyright (c) 2020 Aleksej Komarov
 *! SPDX-License-Identifier: MIT
 */

/**
 * tgui datum (represents a UI).
 */
/datum/tgui
	/// The mob who opened/is using the UI.
	var/mob/user
	/// The object which owns the UI.
	var/datum/src_object
	/// The title of te UI.
	var/title
	/// The window_id for browse() and onclose().
	var/datum/tgui_window/window
	/// Key that is used for remembering the window geometry.
	var/window_key
	/// The interface (template) to be used for this UI.
	var/interface
	/// Update the UI every MC tick.
	var/autoupdate = TRUE
	/// If the UI has been initialized yet.
	var/initialized = FALSE
	/// Time of opening the window.
	var/opened_at
	/// Stops further updates when close() was called.
	var/closing = FALSE
	/// The status/visibility of the UI.
	var/status = UI_INTERACTIVE
	/// Timed refreshing state
	var/refreshing = UI_NOT_REFRESHING
	/// Topic state used to determine status/interactability.
	var/datum/ui_state/state = null
	/// Rate limit client refreshes to prevent DoS.
	COOLDOWN_DECLARE(refresh_cooldown)
	/// Are byond mouse events beyond the window passed in to the ui
	var/mouse_hooked = FALSE
	/// The Parent UI
	var/datum/tgui/parent_ui
	/// Children of this UI
	var/list/children = list()

/**
 * public
 *
 * Create a new UI.
 *
 * required user mob The mob who opened/is using the UI.
 * required src_object datum The object or datum which owns the UI.
 * required interface string The interface used to render the UI.
 * optional title string The title of the UI.
 * optional parent_ui datum/tgui The parent of this UI.
 *
 * return datum/tgui The requested UI.
 */
/datum/tgui/New(mob/user, datum/src_object, interface, title, datum/tgui/parent_ui)
	Logging.log_tgui(user,
		"new [interface] fancy [user?.client?.prefs.tgui_fancy]",
		src_object = src_object)
	src.user = user
	src.src_object = src_object
	src.window_key = "[REF(src_object)]-main"
	src.interface = interface
	if(title)
		src.title = title
	src.state = src_object.ui_state(user)
	src.parent_ui = parent_ui
	if(parent_ui)
		parent_ui.children += src

/datum/tgui/Destroy()
	user = null
	src_object = null
	return ..()

/**
 * public
 *
 * Open this UI (and initialize it with data).
 *
 * return bool - TRUE if a new pooled window is opened, FALSE in all other situations including if a new pooled window didn't open because one already exists.
 */
/datum/tgui/proc/open()
	if(!user.client)
		return FALSE
	if(window)
		return FALSE
	process_status()
	if(status < UI_UPDATE)
		return FALSE
	window = SStgui.request_pooled_window(user)
	if(!window)
		return FALSE
	opened_at = world.time
	window.acquire_lock(src)
	if(!window.is_ready())
		window.initialize(
			strict_mode = TRUE,
			fancy = TRUE,
			// fancy = user.client.prefs.tgui_fancy,
			assets = list(
				get_asset_datum(/datum/asset/simple/tgui),
			))
	else
		window.send_message("ping")
	var/flush_queue = window.send_asset(get_asset_datum(
		/datum/asset/simple/namespaced/fontawesome))
	flush_queue |= window.send_asset(get_asset_datum(
		/datum/asset/simple/namespaced/tgfont))
	for(var/datum/asset/asset in src_object.ui_assets(user))
		flush_queue |= window.send_asset(asset)
	if (flush_queue)
		user.client.browse_queue_flush()
	window.send_message("update", get_payload(
		with_data = TRUE,
		with_static_data = TRUE,
	))
	if(mouse_hooked)
		window.set_mouse_macro()
	SStgui.on_open(src)
	return TRUE

/**
 * public
 *
 * Close the UI.
 *
 * optional can_be_suspended bool
 */
/datum/tgui/proc/close(can_be_suspended = TRUE)
	if(closing)
		return
	closing = TRUE
	// If we don't have window_id, open proc did not have the opportunity
	// to finish, therefore it's safe to skip this whole block.
	if(window)
		// Windows you want to keep are usually blue screens of death
		// and we want to keep them around, to allow user to read
		// the error message properly.
		window.release_lock()
		window.close(can_be_suspended)
		src_object.ui_close(user)
		SStgui.on_close(src)
	state = null
	if(parent_ui)
		parent_ui.children -= src
	parent_ui = null
	qdel(src)

/**
 * public
 *
 * Enable/disable auto-updating of the UI.
 *
 * required value bool Enable/disable auto-updating.
 */
/datum/tgui/proc/set_autoupdate(autoupdate)
	src.autoupdate = autoupdate

/**
 * public
 *
 * Enable/disable passing through byond mouse events to the window
 *
 * required value bool Enable/disable hooking.
 */
/datum/tgui/proc/set_mouse_hook(value)
	src.mouse_hooked = value
	// TODO: handle unhooking/hooking on already open windows ?

/**
 * public
 *
 * Replace current ui.state with a new one.
 *
 * required state datum/ui_state/state Next state
 */
/datum/tgui/proc/set_state(datum/ui_state/state)
	src.state = state

/**
 * public
 *
 * Makes an asset available to use in tgui.
 *
 * required asset datum/asset
 *
 * return bool - true if an asset was actually sent
 */
/datum/tgui/proc/send_asset(datum/asset/asset)
	if(!window)
		CRASH("send_asset() was called either without calling open() first or when open() did not return TRUE.")
	return window.send_asset(asset)

/**
 * public
 *
 * Send a full update to the client (includes static data).
 *
 * optional force bool Send an update even if UI is not interactive.
 * optional hard_refresh block the ui entirely while this is refreshing. use if you don't want users to see an ui during a queued refresh.
 */
/datum/tgui/proc/send_full_update(force, hard_refresh)
	if(!initialized || closing || !user.client)
		return
	if(!COOLDOWN_FINISHED(src, refresh_cooldown))
		refreshing = max(refreshing, hard_refresh? UI_HARD_REFRESHING : UI_SOFT_REFRESHING)
		addtimer(CALLBACK(src, SELF_PROC_REF(send_full_update)), TGUI_REFRESH_FULL_UPDATE_COOLDOWN, TIMER_FLAG_UNIQUE)
		return
	refreshing = UI_NOT_REFRESHING
	var/should_update_data = force || status >= UI_UPDATE
	window.send_message(
		"update",
		get_payload(
		with_data = should_update_data,
		with_static_data = TRUE,
		),
	)
	COOLDOWN_START(src, refresh_cooldown, TGUI_REFRESH_FULL_UPDATE_COOLDOWN)

/**
 * public
 *
 * Send a partial update to the client (excludes static data).
 *
 * optional force bool Send an update even if UI is not interactive.
 */
/datum/tgui/proc/send_update(force)
	if(!user.client || !initialized || closing)
		return
	var/should_update_data = force || status >= UI_UPDATE
	window.send_message("update", get_payload(
		with_data = should_update_data,
	))

/**
 * public
 *
 * Send a partial update to the client of only the provided data lists
 * Does not update config at all
 *
 * WARNING: Do not use this unless you know what you are doing
 *
 * required data The data to send
 * optional force bool Send an update even if UI is not interactive.
 */
/datum/tgui/proc/push_data(data, force)
	if(!user.client || !initialized || closing)
		return
	if(!force && status < UI_UPDATE)
		return
	window.send_message("data", data)

/**
 * private
 *
 * Package the data to send to the UI, as JSON.
 *
 * return list
 */
/datum/tgui/proc/get_payload(with_data, with_static_data)
	var/list/json_data = list()
	json_data["config"] = list(
		"title" = title,
		"status" = status,
		"interface" = interface,
		"refreshing" = refreshing,
		"window" = list(
			"key" = window_key,
			"fancy" = user.client.prefs.tgui_fancy,
			"locked" = user.client.prefs.tgui_lock,
		),
		"client" = list(
			"ckey" = user.client.ckey,
			"address" = user.client.address,
			"computer_id" = user.client.computer_id,
		),
		"user" = list(
			"name" = "[user]",
			"observer" = isobserver(user),
		),
	)
	var/list/modules
	// static first
	if(with_static_data)
		json_data["static"] = src_object.ui_static_data(user, src, state)
		modules = src_object.ui_module_static(user, src, state)
	if(with_data)
		json_data["data"] = src_object.ui_data(user, src, state)
		modules = (modules || list()) | src_object.ui_module_data(user, src, state)
	if(modules)
		json_data["modules"] = modules
	if(src_object.tgui_shared_states)
		json_data["shared"] = src_object.tgui_shared_states
	return json_data

/**
 * private
 *
 * Run an update cycle for this UI. Called internally by SStgui
 * every second or so.
 */
/datum/tgui/process(delta_time, force = FALSE)
	if(closing)
		return
	var/datum/host = src_object.ui_host(user)
	// If the object or user died (or something else), abort.
	if(QDELETED(src_object) || QDELETED(host) || QDELETED(user) || QDELETED(window))
		close(can_be_suspended = FALSE)
		return
	// Validate ping
	if(!initialized && world.time - opened_at > TGUI_PING_TIMEOUT)
		Logging.log_tgui(user, "Error: Zombie window detected, closing.",
			window = window,
			src_object = src_object)
		close(can_be_suspended = FALSE)
		return
	// Update through a normal call to ui_interact
	if(status != UI_DISABLED && (autoupdate || force))
		src_object.ui_interact(user, src, parent_ui)
		return
	// Update status only
	var/needs_update = process_status()
	if(status <= UI_CLOSE)
		close()
		return
	if(needs_update)
		window.send_message("update", get_payload())

/**
 * private
 *
 * Updates the status, and returns TRUE if status has changed.
 */
/datum/tgui/proc/process_status()
	var/prev_status = status
	status = src_object.ui_status(user, state)
	if(parent_ui)
		status = min(status, parent_ui.status)
	return prev_status != status

/**
 * private
 *
 * Callback for handling incoming tgui messages.
 */
/datum/tgui/proc/on_message(type, list/payload, list/href_list)
	if(type)
		// micro opt in that these routes are same length so we only copytext once
		switch(copytext(type, 1, 5))
			if("act/")	// normal act
				var/action = copytext(type, 5)
				Logging.log_tgui(user, "Action: [action] [href_list["payload"]]",
					window = window,
					src_object = src_object)
				process_status()
				if(src_object.ui_act(action, payload, src))
					SStgui.update_uis(src_object)
				return FALSE
			if("mod/")	// module act
				var/action = copytext(type, 5)
				var/id = payload["$m_id"]
				// log, update status
				Logging.log_tgui(user, "Module: [action] [href_list["payload"]]",
					window = window,
					src_object = src_object)
				process_status()
				// tell it to route the call
				// note: this is pretty awful code because raw locate()'s are
				// almost never a good idea
				// however given we don't have a way of just tracking a ui module list (yet)
				// we're kind of stuck doing this
				// maybe in the future we'll just have ui modules list but for now
				// eh.
				if(src_object.ui_module_route(action, payload, src, id))
					SStgui.update_uis(src_object)
				return FALSE
	switch(type)
		if("ready")
			// Send a full update when the user manually refreshes the UI
			if(initialized)
				send_full_update()
			initialized = TRUE
		if("ping/reply")
			initialized = TRUE
		if("suspend")
			close(can_be_suspended = TRUE)
		if("close")
			close(can_be_suspended = FALSE)
		if("log")
			if(href_list["fatal"])
				close(can_be_suspended = FALSE)
		if("setSharedState")
			if(status != UI_INTERACTIVE)
				return
			LAZYLIST_INIT(src_object.tgui_shared_states)
			src_object.tgui_shared_states[href_list["key"]] = href_list["value"]
			SStgui.update_uis(src_object)
