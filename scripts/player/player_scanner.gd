class_name PlayerScanner
extends Node

@export var scan_range := 8.0
@export var scan_cooldown := 0.2

var active := false
var player: CharacterBody3D
var last_scan_time := 0.0
var current_highlight: Node = null

func _ready() -> void:
	player = get_parent().get_parent() as CharacterBody3D
	if player == null:
		push_warning("PlayerScanner: parent hierarchy is invalid")
		return
	EventBus.scanner_status_changed.emit("SCANNER OFF", false)

func toggle() -> void:
	if player == null:
		return
	var now := Time.get_ticks_msec() / 1000.0
	if now - last_scan_time < scan_cooldown:
		return
	last_scan_time = now
	active = not active
	_refresh_scan_state()

func _physics_process(_delta: float) -> void:
	if active:
		_refresh_scan_state()

func _refresh_scan_state() -> void:
	var summary := "SCANNER OFF"
	if active:
		summary = "SCANNER ONLINE"
		var target := _find_best_target()
		if target != null:
			if current_highlight != target:
				_set_highlight(current_highlight, false)
				_set_highlight(target, true)
				current_highlight = target
			var category: String = str(target.get_scan_category()) if target.has_method("get_scan_category") else "INTERACTABLE"
			var details: String = str(target.get_scan_details()) if target.has_method("get_scan_details") else target.name
			summary = "%s // %s" % [category, details]
		else:
			_set_highlight(current_highlight, false)
			current_highlight = null
			summary = "NO TARGET IN RANGE"
	else:
		_set_highlight(current_highlight, false)
		current_highlight = null
	EventBus.scanner_status_changed.emit(summary, active)

func _find_best_target() -> Node:
	if player == null:
		return null
	var best_target: Node = null
	var best_distance := INF
	for candidate in get_tree().get_nodes_in_group("interactable"):
		if not candidate.has_method("can_interact"):
			continue
		if not candidate.can_interact(player):
			continue
		var distance := player.global_position.distance_to(candidate.global_position)
		if distance > scan_range:
			continue
		if distance < best_distance:
			best_target = candidate
			best_distance = distance
	return best_target

func _set_highlight(target: Node, enabled: bool) -> void:
	if target == null:
		return
	for child in target.get_children():
		if not child is MeshInstance3D:
			continue
		var material := child.material_override as StandardMaterial3D
		if material == null:
			material = StandardMaterial3D.new()
			child.material_override = material
		material.emission_enabled = enabled
		material.emission = Color(0.42, 0.9, 1.0) if enabled else Color(0.0, 0.0, 0.0)
