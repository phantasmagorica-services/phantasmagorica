
#warn yikes

#define GLOBAL_VAR(NAME) \
/datum/controller/globals/var/##NAME;

#define GLOBAL_VAR_INIT(NAME, VAL) \
/datum/controller/globals/var/##NAME;

#define GLOBAL_LIST(NAME) \
/datum/controller/globals/var/list/##NAME;

#define GLOBAL_LIST_INIT(NAME, VAL) \
/datum/controller/globals/var/list/##NAME;

#define GLOBAL_LIST_EMPTY(NAME, VAL) \
/datum/controller/globals/var/list/##NAME;

#define GLOBAL_DATUM(NAME, PATH) \
/datum/controller/globals/var##PATH/##NAME;

#define GLOBAL_DATUM_INIT(NAME, PATH, VAL) \
/datum/controller/globals/var##PATH/##NAME;
