extends Node
## Versioned, validated save boundary for offline progression.
const SAVE_PATH := "user://neon_trace_save.json"
const SAVE_VERSION := 1
var save_data: Dictionary

func _ready() -> void:
	reset()
	EventBus.system_ready.emit("SaveManager")

func snapshot() -> Dictionary:
	return save_data.duplicate(true)

func capture_runtime_state() -> Dictionary:
	var runtime_state := {
		"save_version": SAVE_VERSION,
		"mission": GameManager.current_mission_id if GameManager != null else "",
		"checkpoint": GameManager.current_checkpoint_id if GameManager != null else "",
		"completed_missions": [],
		"evidence": [],
		"tools": [],
		"story_flags": {},
		"settings": {},
		"ending_state": ""
	}
	if GameManager != null:
		runtime_state["story_flags"] = GameManager.story_flags.duplicate(true)
	if self.has_method("_collect_runtime_evidence"):
		runtime_state["evidence"] = _collect_runtime_evidence()
	if SettingsManager != null:
		runtime_state["settings"] = SettingsManager.values.duplicate(true)
	return runtime_state

func apply_runtime_state(data: Dictionary) -> bool:
	if data.is_empty():
		return false
	if not _is_valid_save(data):
		push_warning("SaveManager: invalid save ignored; starting a new session")
		return false
	if GameManager != null:
		GameManager.current_mission_id = data.get("mission", "")
		GameManager.current_checkpoint_id = data.get("checkpoint", "")
		GameManager.story_flags = data.get("story_flags", {}).duplicate(true)
	save_data = data
	return true

func save() -> bool:
	save_data = capture_runtime_state()
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("SaveManager: unable to open save path for writing: %s" % SAVE_PATH)
		return false
	file.store_string(JSON.stringify(save_data))
	file.close()
	return true

func load_save() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("SaveManager: unable to open save path for reading: %s" % SAVE_PATH)
		return false
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	if not parsed is Dictionary or not _is_valid_save(parsed):
		push_warning("SaveManager: invalid save ignored; starting a new session")
		return false
	save_data = parsed
	return apply_runtime_state(parsed)

func reset() -> void:
	save_data = {
		"save_version": SAVE_VERSION,
		"mission": "",
		"checkpoint": "",
		"completed_missions": [],
		"evidence": [],
		"tools": [],
		"story_flags": {},
		"settings": {},
		"ending_state": ""
	}

func _collect_runtime_evidence() -> Array:
	var manager = get_tree().root.get_node_or_null("Game/EvidenceManager")
	if manager == null or not manager.has_method("list_ids"):
		return []
	return manager.list_ids()

func _is_valid_save(candidate: Dictionary) -> bool:
	if candidate.get("save_version", -1) != SAVE_VERSION:
		return false
	for key in ["mission", "checkpoint", "completed_missions", "evidence", "tools", "story_flags", "settings", "ending_state"]:
		if not candidate.has(key):
			return false
	return true
