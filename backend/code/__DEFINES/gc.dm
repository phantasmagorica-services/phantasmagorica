//* /datum/proc/Destroy() hints

/// queue in SSgarbage
#define QDEL_HINT_QUEUE 0
/// disallow deletion
#define QDEL_HINT_FORBID 1
/// we should be deleting, but, we will clean ourselves up (tells subsystem to forget about us)
#define QDEL_HINT_UNMANAGED 2
/// immediately run del after Destroy()
#define QDEL_HINT_IMMEDIATE 3

//* /datum/var/gc_destroyed enums

/// running qdel logic right now
#define GC_IN_DESTROY -1

//* helpers

/// is deleted, or scheduled for garbage collection; or being destroyed right now
#define QDELETED(D) (isnull(D) || D.gc_destroyed != null)
/// is in Destroy() right now
#define QDESTROYING(D) (!isnull(D) && D.gc_destroyed == GC_IN_DESTROY)
