class_name ObjectiveManager
extends Node

var objectives: Dictionary = {}
var ordered_objective_ids: Array[String] = []

func register_objective(objective: Dictionary) -> void:
	if objective.is_empty():
		return
	var objective_id: String = objective.get("id", "")
	if objective_id.is_empty():
		return
	if not objectives.has(objective_id):
		ordered_objective_ids.append(objective_id)
	objectives[objective_id] = objective

func complete_objective(objective_id: String) -> bool:
	if not objectives.has(objective_id):
		return false
	var objective: Dictionary = objectives[objective_id]
	objective["completed"] = true
	objectives[objective_id] = objective
	return true

func get_current_objective() -> Dictionary:
	for objective_id in ordered_objective_ids:
		var objective: Dictionary = objectives.get(objective_id, {})
		if not objective.get("completed", false):
			return objective
	return {}

func get_all_objectives() -> Array:
	var result: Array = []
	for objective_id in ordered_objective_ids:
		result.append(objectives.get(objective_id, {}))
	return result

func get_completion_ratio() -> float:
	if ordered_objective_ids.is_empty():
		return 0.0
	var completed_count := 0
	for objective_id in ordered_objective_ids:
		if objectives.get(objective_id, {}).get("completed", false):
			completed_count += 1
	return float(completed_count) / float(ordered_objective_ids.size())

func clear() -> void:
	objectives.clear()
	ordered_objective_ids.clear()
