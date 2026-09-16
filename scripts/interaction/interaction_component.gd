class_name InteractionComponent
extends Node

@export var max_distance := 3.5
@export var interaction_mask := 1

var current_target: Node = null
var interaction_origin: Node3D
var player: CharacterBody3D

func _ready() -> void:
	player = get_parent() as CharacterBody3D
	interaction_origin = get_node_or_null("../InteractionOrigin") as Node3D
	if interaction_origin == null:
		interaction_origin = player

func _physics_process(_delta: float) -> void:
	var target := _find_best_target()
	if target != current_target:
		current_target = target
		if target != null:
			EventBus.interaction_prompt_changed.emit(target.get_interaction_prompt(), true)
		else:
			EventBus.interaction_prompt_changed.emit("", false)

func try_interact() -> void:
	if current_target == null:
		return
	if current_target.has_method("interact"):
		current_target.interact(player)
		if current_target.has_method("get_interaction_prompt"):
			EventBus.interaction_prompt_changed.emit(current_target.get_interaction_prompt(), true)

func _find_best_target() -> Node:
	var best_target: Node = null
	var best_priority := -INF
	var origin: Vector3 = interaction_origin.global_position
	var forward: Vector3 = -player.global_basis.z
	var ray_end := origin + (forward * max_distance)
	var ray_params := PhysicsRayQueryParameters3D.create(origin, ray_end, interaction_mask, [player])
	var result := player.get_world_3d().direct_space_state.intersect_ray(ray_params)
	var ray_hit: Node = null
	if result.has("collider") and result["collider"] != null:
		ray_hit = result["collider"]

	for candidate in get_tree().get_nodes_in_group("interactable"):
		if not candidate.has_method("can_interact"):
			continue
		if not candidate.can_interact(player):
			continue
		var distance := player.global_position.distance_to(candidate.global_position)
		if distance > max_distance + 1.5:
			continue
		var priority := candidate.get_interaction_priority()
		if ray_hit != null and (candidate == ray_hit or ray_hit.is_ancestor_of(candidate) or candidate.is_ancestor_of(ray_hit)):
			priority += 50.0
		if priority > best_priority:
			best_target = candidate
			best_priority = priority
	return best_target
