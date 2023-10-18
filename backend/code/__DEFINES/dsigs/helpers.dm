/// raise a datum signal with the given arguments
/// returns the flags returned from the signal
#define RAISE_SIGNAL(DELEGATE, SIGNAL, ARGS...) isnull(DELEGATE.signal_lookup?[SIGNAL])? DELEGATE.__raise_signal(SIGNAL, ##ARGS) : NONE

/// declares something a signal handler
/// this follows sdmm's define conventions
#define SIGNAL_HANDLER_PROC(VAL) SHOULD_NOT_SLEEP(TRUE)
