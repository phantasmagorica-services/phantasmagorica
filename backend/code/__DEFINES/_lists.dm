#define LAZYLIST_ADD(L, I) if(isnull(L)) { L = list(); }; L += I;
#define LAZYLIST_REMOVE(L, I) if(!isnull(L)) { L -= I; if(length(L) == 0) {L = null}; };
#define LAZYLIST_FIND(L, I) L?.Find(I)
#define LAZYLIST_INIT(L) if(isnull(L)) { L = list(); };

#warn LAZYLIST defines
