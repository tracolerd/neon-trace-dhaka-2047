class_name NetworkNode
extends RefCounted

var id: String = ""
var label: String = ""
var value: String = ""
var active: bool = false

func _init(p_id: String = "", p_label: String = "", p_value: String = "") -> void:
	id = p_id
	label = p_label
	value = p_value
