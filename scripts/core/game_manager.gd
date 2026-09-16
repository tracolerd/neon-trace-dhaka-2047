extends Node
## High-level application state. Gameplay-specific state belongs to its owning system.
const VERSION := 1
var is_initialized := false
var current_mission_id := ""
var current_checkpoint_id := ""
var story_flags: Dictionary = {}

func _ready() -> void:
	is_initialized = true
	EventBus.system_ready.emit("GameManager")

func reset_session() -> void:
	current_mission_id = ""
	current_checkpoint_id = ""
	story_flags.clear()

func set_story_flag(flag_name: String, value: Variant) -> void:
	if flag_name.is_empty():
		return
	story_flags[flag_name] = value

func get_story_flag(flag_name: String, fallback: Variant = null) -> Variant:
	if not story_flags.has(flag_name):
		return fallback
	return story_flags[flag_name]

func has_story_flag(flag_name: String) -> bool:
	return story_flags.has(flag_name)

func get_runtime_snapshot() -> Dictionary:
	return {
		"current_mission_id": current_mission_id,
		"current_checkpoint_id": current_checkpoint_id,
		"story_flags": story_flags.duplicate(true)
	}
