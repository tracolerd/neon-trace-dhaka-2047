class_name GuardDetection
extends Node

static func evaluate_player(player: Node3D, guard: NPCController) -> float:
	if player == null or guard == null:
		return 0.0
	var distance := player.global_position.distance_to(guard.global_position)
	if distance > guard.vision_range:
		return 0.0
	var view_factor: float = 1.0 - (distance / max(guard.vision_range, 0.1))
	var stealth_factor: float = view_factor * 0.6
	return clamp(stealth_factor, 0.0, 1.0)
