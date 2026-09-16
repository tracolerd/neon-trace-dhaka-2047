extends Node
## Boot validation and initial scene loading.
@onready var status_label: Label = $LoadingUI/Status

func _ready() -> void:
	if status_label == null:
		push_warning("Boot: status label unavailable; continuing without UI updates")
	else:
		status_label.text = "INITIALIZING NEON//TRACE SYSTEMS..."
	if not _validate_configuration():
		if status_label != null:
			status_label.text = "BOOT ERROR - SEE OUTPUT"
		return
	if status_label != null:
		status_label.text = "SYSTEMS ONLINE"
	await get_tree().process_frame
	await get_tree().process_frame
	if SceneManager != null and SceneManager.has_method("change_scene"):
		SceneManager.change_scene("res://scenes/core/Game.tscn")
	else:
		push_error("Boot: SceneManager is not available")

func _validate_configuration() -> bool:
	var required_actions := ["move_forward", "move_backward", "move_left", "move_right", "interact", "scanner", "pause", "jump", "sprint", "crouch"]
	for action in required_actions:
		if not InputMap.has_action(action):
			push_error("Boot: required input action missing: %s" % action)
			return false
	if not ResourceLoader.exists("res://scenes/core/Game.tscn"):
		push_error("Boot: required game scene is missing")
		return false
	return true
