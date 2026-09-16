class_name Interactable
extends Node3D

func _ready() -> void:
	if not is_in_group("interactable"):
		add_to_group("interactable")

func can_interact(_player: Node3D) -> bool:
	return false

func interact(_player: Node3D) -> void:
	pass

func get_interaction_prompt() -> String:
	return "[E] INTERACT"

func get_interaction_priority() -> float:
	return 0.0

func get_scan_category() -> String:
	return "INTERACTABLE"

func get_scan_details() -> String:
	return name

func set_highlighted(_enabled: bool) -> void:
	for child in get_children():
		if child is MeshInstance3D:
			var material := child.material_override as StandardMaterial3D
			if material == null:
				material = StandardMaterial3D.new()
				child.material_override = material
			material.emission_enabled = _enabled
			material.emission = Color(0.42, 0.9, 1.0) if _enabled else Color(0.0, 0.0, 0.0)
