/// raise a datum signal with the given arguments
/// returns the flags returned from the signal
#define RAISE_SIGNAL(DELEGATE, SIGNAL, ARGS...) isnull(DELEGATE.signal_lookup?[SIGNAL])? DELEGATE.__raise_signal(SIGNAL, ##ARGS) : NONE
