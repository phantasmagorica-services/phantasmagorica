/**
 *! Copyright (c) 2020 Aleksej Komarov
 *! SPDX-License-Identifier: MIT
 */

/**
 * tgui state: default
 *
 * which is just 'always' here, because we're a silly ttrpg, not space station.
 */
GLOBAL_DATUM_INIT(default_state, /datum/ui_state/default_state, new)

/datum/ui_state/default_state/can_use_topic(src_object, mob/user)
	return UI_INTERACTIVE
