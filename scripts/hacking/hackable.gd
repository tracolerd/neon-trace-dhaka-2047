class_name Hackable
extends Node

func get_security_level() -> int:
	return 0

func get_hack_type() -> String:
	return "UNKNOWN"

func begin_hack(_player: Node) -> void:
	pass

func on_hack_success() -> void:
	pass

func on_hack_failure() -> void:
	pass
