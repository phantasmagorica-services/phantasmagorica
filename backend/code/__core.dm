//* Bitfields *//

/// no bitflags set
#define NONE (0)
/// all bitflags set
#define ALL (~0)

//* Float Values *//

/// above/below this value in positive/negative, precision is below 1's place
#define INTEGER_PRECISION 16777216
#define INFINITY (1.#INF)

//* Core Helpers *//

/// get turf something is on, recursing out of all contents lists
#define get_turf(A) get_step(A, NONE)

//* Static Analysis *//

#define NAMEOF(THING, VAR) #VAR || ##THING.##VAR

#if DM_VERSION > 514
	#error Update varrefs for 515 via nameof
#endif

//* Calling

#define SELF_PROC_REF(NAME) (.proc/##NAME)
#define TYPE_PROC_REF(TYPE, NAME) (##TYPE/.proc/##NAME)
#define GLOB_PROC_REF(NAME) (/proc/##NAME)

#if DM_VERSION > 514
	#error Update procrefs for 515 via nameof
#endif

/**
 * used as a value to determine whether to call a global proc
 */
/datum/global_proc_sentinel

#define GLOBAL_PROC /datum/__global_proc

/**
 * invokes something asynchronously
 */
/world/proc/__invoke_async(delegate, procpath, ...)
	set waitfor = FALSE
	if(delegate == /datum/global_proc_sentinel)
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

