/// sleep current proc if tick is over a certain amount of usage
#define YIELD(tick_amount) if(world.tick_usage > tick_amount) sleep(world.tick_lag)
/// sleep current proc if lagging
#define YIELD_AUTO YIELD(80)

#warn better tick logic
