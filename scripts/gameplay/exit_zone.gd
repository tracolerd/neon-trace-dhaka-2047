class_name ExitZone
extends Area3D

@export var mission_id: String = "mission_01_finding_the_backdoor"
@export var objective_id: String = "secure_exit"
@export var required_objectives: Array[String] = ["scan_terminal", "recover_evidence"]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	monitoring = true
	monitorable = true

func _on_body_entered(body: Node3D) -> void:
	if body == null:
		return
	if not body.is_in_group("player"):
		return
	var manager = get_tree().root.get_node_or_null("Game/MissionManager")
	if manager == null:
		EventBus.notification_requested.emit("Exit zone unavailable: mission controller missing", "warning")
		return
	for objective_name in required_objectives:
		var objective_data: Dictionary = manager.objective_manager.objectives.get(objective_name, {})
		if not objective_data.get("completed", false):
			EventBus.notification_requested.emit("Exit denied: %s not yet complete" % objective_name, "warning")
			return
	var result := manager.complete_objective(objective_id)
	if result:
		var checkpoint = get_tree().root.get_node_or_null("Game/CheckpointManager")
		if checkpoint != null and checkpoint.has_method("trigger"):
			checkpoint.trigger("mission_completed")
		if GameManager != null:
			GameManager.set_story_flag("mission_exit_secured", true)
		if SaveManager != null and SaveManager.has_method("save"):
			SaveManager.save()
		EventBus.notification_requested.emit("Exit secured. Signal routed to the ghost relay.", "success")
		EventBus.player_action.emit("mission_exit_reached", {"mission_id": mission_id, "objective_id": objective_id})
	else:
		EventBus.notification_requested.emit("Exit objective already resolved.", "system")
