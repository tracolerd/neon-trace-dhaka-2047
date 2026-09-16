class_name MissionTrigger
extends Area3D

@export var mission_id: String = ""
@export var trigger_name: String = "mission_started"
@export var trigger_once: bool = true

var has_triggered: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	monitoring = true

func _on_body_entered(body: Node3D) -> void:
	if body == null or has_triggered:
		return
	if not body.is_in_group("player") and not body.name.contains("Player"):
		return
	var manager = get_tree().root.get_node_or_null("Game/MissionManager")
	if manager != null and not mission_id.is_empty():
		manager.start_mission(mission_id)
	var checkpoint = get_tree().root.get_node_or_null("Game/CheckpointManager")
	if checkpoint != null and checkpoint.has_method("trigger"):
		checkpoint.trigger(trigger_name)
	has_triggered = trigger_once
	if trigger_once:
		queue_free()
