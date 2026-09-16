class_name NPCStateMachine
extends Node

var current_state := "PATROL"

func set_state(name: String) -> void:
	current_state = name
