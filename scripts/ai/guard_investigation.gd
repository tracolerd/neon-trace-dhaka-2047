class_name GuardInvestigation
extends Node

func update_investigation(guard: NPCController, target_position: Vector3, delta: float) -> void:
	if guard == null:
		return
	var direction := target_position - guard.global_position
	if direction.length() > 0.5:
		guard.velocity = direction.normalized() * 2.4
		guard.move_and_slide()
