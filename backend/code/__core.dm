//* Bitfields *//

/// no bitflags set
#define NONE (0)
/// all bitflags set
#define ALL (~0)

//* Float Values *//

/// above/below this value in positive/negative, precision is below 1's place
#define INTEGER_PRECISION (2**24)
#define INFINITY (1.#INF)

//* Core Helpers *//

/// get turf something is on, recursing out of all contents lists
#define get_turf(A) get_step(A, NONE)

//* Static Analysis *//

#define NAMEOF(THING, VAR) #VAR || ##THING.##VAR

//* Calling

#if DM_VERSION < 515
	#define SELF_PROC_REF(X) (.proc/##X)
	#define TYPE_PROC_REF(TYPE, X) (##TYPE.proc/##X)
	#define GLOBAL_PROC_REF(X) (/proc/##X)
#else
	#define SELF_PROC_REF(X) (nameof(.proc/##X))
	#define TYPE_PROC_REF(TYPE, X) (nameof(##TYPE.proc/##X))
	#define GLOBAL_PROC_REF(X) (/proc/##X)
#endif

/**
 * used as a value to determine whether to call a global proc
 */
/datum/__global_proc_sentinel

#define GLOBAL_PROC /datum/__global_proc_sentinel

/**
 * invokes something asynchronously
 */
/world/proc/__invoke_async(delegate, procpath, ...)
	set waitfor = FALSE
	if(delegate == /datum/__global_proc_sentinel)
		call(procpath)(arglist(args.Copy(3)))
	else
		call(delegate, procpath)(arglist(args.Copy(3)))

/// Use as ASYNC_CALL(object, function, ...); function references must be X_PROC_REF macro outputs,
/// and object should be GLOBAL_PROC if function is global.
#define ASYNC_CALL(DELEGATE, PROCPATH, ARGS...) world.__invoke_async(DELEGATE, PROCPATH, ARGS)

#if DM_VERSION > 514
/// Use as DYLIB_CALL(path, function)(...) where ... is args.
#define DYLIB_CALL call_ext
#else
/// Use as DYLIB_CALL(path, function)(...) where ... is args.
#define DYLIB_CALL call
#endif

//* Deletion

#define QDEL_NULL(THING) if(!isnull(THING)) { qdel(THING); THING = null; };
#define QDEL_LIST(LIST) if(!isnull(LIST)) { for(var/i in 1 to length(LIST)) { qdel(LIST[i]); }; LIST.len = 0; LIST = null;}
#define QDEL_LIST_ASSOC_VAL if(!isnull(LIST)) { for(var/key in LIST) { qdel(LIST[key]); }; LIST.len = 0; LIST = null;}
#define QDEL_LIST_ASSOC_KEY if(!isnull(LIST)) { for(var/key in LIST) { qdel(key); }; LIST.len = 0; LIST = null;}

//* Grabbing mob / clients from mob-client variables

/// Gets mob from a var that holds mob or client, if the var is valid
#define MOB_FROM_VAR(V) (istype(V, /client)? (V:mob) : (ismob(V)? V : null))
/// Gets client from a var that holds mob or client, if the var is valid
#define CLIENT_FROM_VAR(V) (istype(V, /client)? (V) : (ismob(V)? V:client : null))
