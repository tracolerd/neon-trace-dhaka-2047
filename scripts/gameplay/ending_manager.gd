class_name EndingManager
extends Node

var endings: Dictionary = {
	"ghost_signal": {
		"title": "Ghost Signal",
		"description": "You escape with the corrupted signal and remain a ghost in the system."
	},
	"blackout": {
		"title": "Blackout",
		"description": "You trigger a citywide shutdown and vanish into the dark."
	},
	"remnant": {
		"title": "Remnant Protocol",
		"description": "The city remembers what you stole, and the machine learns your face."
	}
}

var current_ending_id: String = ""

func _ready() -> void:
	EventBus.system_ready.emit("EndingManager")

func resolve_ending_from_state() -> String:
	if GameManager == null:
		return "ghost_signal"
	if GameManager.has_story_flag("mission_exit_secured"):
		current_ending_id = "ghost_signal"
	elif GameManager.has_story_flag("alert_overload"):
		current_ending_id = "blackout"
	else:
		current_ending_id = "remnant"
	EventBus.ending_reached.emit(current_ending_id, endings[current_ending_id].get("title", current_ending_id))
	return current_ending_id

func get_current_ending() -> Dictionary:
	if current_ending_id.is_empty():
		resolve_ending_from_state()
	if not endings.has(current_ending_id):
		return {"title": "Unknown", "description": "No ending resolved."}
	return endings[current_ending_id]

func set_ending(ending_id: String) -> bool:
	if not endings.has(ending_id):
		return false
	current_ending_id = ending_id
	EventBus.ending_reached.emit(current_ending_id, endings[current_ending_id].get("title", ending_id))
	return true
