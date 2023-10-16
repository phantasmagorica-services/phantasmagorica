//* multipliers to turn things into deciseconds (byond time)

#define SECONDS * 10
#define MINUTES * (10 * 60)
#define HOURS * (10 * 60 * 60)

//* helpers

/// just world.time
#define GAME_TIME world.time
/// midnight rollover guarded time of day
//  todo: this isn't even made yet
#define REAL_TIME world.timeofday
