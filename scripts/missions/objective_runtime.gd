class_name ObjectiveRuntime
extends RefCounted

var objective_id: String = ""
var title: String = ""
var completed: bool = false

func _init(p_objective_id: String = "", p_title: String = "") -> void:
	objective_id = p_objective_id
	title = p_title
