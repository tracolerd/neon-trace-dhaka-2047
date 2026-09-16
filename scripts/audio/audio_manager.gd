extends Node
## Initializes the game's audio buses and owns high-level music state.
const MUSIC_STATES := ["EXPLORE", "TENSION", "DETECTED", "PURSUIT", "ESCAPE", "REVELATION"]
const BUS_NAMES := ["Master", "Music", "SFX", "Ambience", "Voice", "UI"]
var current_music_state := "EXPLORE"

func _ready() -> void:
	_ensure_buses()
	EventBus.system_ready.emit("AudioManager")

func set_music_state(state: String) -> void:
	if state not in MUSIC_STATES:
		push_warning("AudioManager: unsupported music state: %s" % state)
		return
	current_music_state = state

func _ensure_buses() -> void:
	for bus_name in BUS_NAMES:
		if AudioServer.get_bus_index(bus_name) == -1:
			AudioServer.add_bus()
			AudioServer.set_bus_name(AudioServer.bus_count - 1, bus_name)
