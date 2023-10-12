//* /datum/proc/Destroy() hints

/// queue in SSgarbage
#define QDEL_HINT_QUEUE 0
/// completely ignore qdel
#define QDEL_HINT_IGNORE 1
/// immediately run Del() after Destroy()
#define QDEL_HINT_IMMEDIATE 2

//* /datum/var/gc_destroyed enums

/// running Destroy() right now
#define GC_IN_DESTROY -1

//* helpers

/// is deleted, or scheduled for garbage collection; or being destroyed right now
#define QDELETED(D) (isnull(D) || D.gc_destroyed != null)
/// is in Destroy() right now
#define QDESTROYING(D) (!isnull(D) && D.gc_destroyed == GC_IN_DESTROY)
