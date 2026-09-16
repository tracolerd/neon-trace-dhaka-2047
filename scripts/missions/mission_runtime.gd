class_name MissionRuntime
extends RefCounted

var mission_id: String = ""
var title: String = ""
var description: String = ""
var objective_ids: Array[String] = []
var current_objective_id: String = ""
var completed_objectives: Array[String] = []
var is_active: bool = false

func _init(p_mission_id: String = "", p_title: String = "", p_description: String = "", p_objective_ids: Array[String] = []) -> void:
	mission_id = p_mission_id
	title = p_title
	description = p_description
	objective_ids = p_objective_ids.duplicate()
	is_active = true
	if objective_ids.is_empty():
		return
	current_objective_id = objective_ids[0]

func register_objective(objective_id: String) -> void:
	if objective_id.is_empty() or objective_ids.has(objective_id):
		return
	objective_ids.append(objective_id)
	if current_objective_id.is_empty():
		current_objective_id = objective_id

func complete_objective(objective_id: String) -> bool:
	if not objective_ids.has(objective_id):
		return false
	if not completed_objectives.has(objective_id):
		completed_objectives.append(objective_id)
	if objective_ids.find(current_objective_id) == objective_ids.size() - 1:
		current_objective_id = ""
		return true
	var current_index := objective_ids.find(current_objective_id)
	if current_index >= 0:
		var next_index := current_index + 1
		if next_index < objective_ids.size():
			current_objective_id = objective_ids[next_index]
	return true

func is_complete() -> bool:
	return objective_ids.is_empty() or completed_objectives.size() >= objective_ids.size()

func get_progress_text() -> String:
	if objective_ids.is_empty():
		return "Mission initialized"
	return "%s / %s objectives cleared" % [completed_objectives.size(), objective_ids.size()]
