extends Node
## Persists user-facing settings through Godot's per-user configuration path.
const SETTINGS_PATH := "user://settings.cfg"
const DEFAULTS := {
	"camera_sensitivity": 1.0,
	"invert_camera_y": false,
	"reduced_camera_shake": false,
	"subtitle_size": 1.0,
	"master_volume": 1.0,
	"music_volume": 0.8,
	"sfx_volume": 0.9
}
var values: Dictionary = DEFAULTS.duplicate(true)

func _ready() -> void:
	_load()
	EventBus.system_ready.emit("SettingsManager")

func get_value(key: String, fallback: Variant = null) -> Variant:
	return values.get(key, fallback)

func set_value(key: String, value: Variant) -> void:
	if not DEFAULTS.has(key):
		push_warning("SettingsManager: unknown setting ignored: %s" % key)
		return
	values[key] = value
	_save()

func _load() -> void:
	var config := ConfigFile.new()
	var error := config.load(SETTINGS_PATH)
	if error == ERR_FILE_NOT_FOUND:
		return
	if error != OK:
		push_warning("SettingsManager: could not load settings (%s); using defaults" % error)
		return
	for key in DEFAULTS:
		if config.has_section_key("settings", key):
			values[key] = config.get_value("settings", key)

func _save() -> void:
	var config := ConfigFile.new()
	for key in values:
		config.set_value("settings", key, values[key])
	var error := config.save(SETTINGS_PATH)
	if error != OK:
		push_error("SettingsManager: could not save settings (%s)" % error)
