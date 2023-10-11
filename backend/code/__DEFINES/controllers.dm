
#warn impl

#define CONTROLLER_DEF(NAME, VARNAME) \
var/global/datum/controller/##NAME/##VARNAME; \
/datum/controller/##NAME {}

#define SUBSYSTEM_DEF(NAME) \
var/global/datum/controller/subsystem/##NAME/SS##NAME; \
/datum/controller/subsystem/##NAME {}

#define REPOSITORY_DEF(NAME) \
var/global/datum/controller/repository/##NAME/RS##NAME; \
/datum/controller/repository/##NAME {}

#define ENTITYMAP_DEF(NAME) \
var/global/datum/controller/entitymap/##NAME/ES##NAME; \
/datum/controller/entitymap/##NAME {}
