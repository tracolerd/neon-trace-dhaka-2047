class_name GuardController
extends NPCController

var detection_level := 0.0
var investigation_target: Vector3 = Vector3.ZERO
var security_manager: Node = null
var awareness_state := "CALM"

func _ready() -> void:
	super._ready()
	security_manager = get_tree().root.get_node_or_null("Game/SecurityManager")
	add_to_group("guard")

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	var player = get_tree().root.get_node_or_null("Game/Player")
	if player != null:
		detection_level = GuardDetection.evaluate_player(player, self)
		if detection_level > 0.0:
			state_name = "SUSPICIOUS"
			awareness_state = "SUSPICIOUS"
			investigation_target = player.global_position
			if detection_level > 0.6:
				state_name = "ALERT"
				awareness_state = "ALERT"
				var direction: Vector3 = player.global_position - global_position
				if direction.length() > 0.1:
					velocity = direction.normalized() * 2.8
					move_and_slide()
				if security_manager != null and security_manager.has_method("add_intensity"):
					security_manager.add_intensity(12.0 * delta)
			if GameManager != null and detection_level > 0.85:
				GameManager.set_story_flag("alert_overload", true)
		else:
			state_name = "PATROL"
			awareness_state = "CALM"
			investigation_target = Vector3.ZERO
			if security_manager != null and security_manager.has_method("reduce_intensity"):
				security_manager.reduce_intensity(3.0 * delta)
		if GameManager != null and detection_level > 0.1:
			GameManager.set_story_flag("guard_detected_player", true)
		else:
			GameManager.set_story_flag("guard_detected_player", false)

	if detection_level > 0.1:
		if security_manager != null and security_manager.has_method("add_intensity"):
			security_manager.add_intensity(2.0 * delta)

	if detection_level > 0.95 and GameManager != null:
		GameManager.set_story_flag("mission_failed_alert", true)
		EventBus.notification_requested.emit("ALERT: hostile patrol has locked onto your trail", "warning")
