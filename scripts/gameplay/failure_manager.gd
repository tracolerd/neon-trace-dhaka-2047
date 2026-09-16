class_name FailureManager
extends Node

var last_failure_reason: String = ""
var reset_position: Vector3 = Vector3.ZERO

func _ready() -> void:
	EventBus.system_ready.emit("FailureManager")

func trigger_failure(reason: String = "alert") -> void:
	last_failure_reason = reason
	var mission_id := GameManager.current_mission_id if GameManager != null else "mission_01_finding_the_backdoor"
	EventBus.mission_failed.emit(mission_id, reason)
	EventBus.notification_requested.emit("MISSION FAILED: %s" % reason.to_upper(), "warning")
	if GameManager != null:
		GameManager.set_story_flag("mission_failed", true)
		GameManager.set_story_flag("failure_reason", reason)

func reset_player_position() -> void:
	var player = get_tree().root.get_node_or_null("Game/Player")
	if player == null:
		return
	player.global_position = reset_position
	if player.has_method("set_velocity"):
		player.velocity = Vector3.ZERO

func set_reset_position(position: Vector3) -> void:
	reset_position = position
