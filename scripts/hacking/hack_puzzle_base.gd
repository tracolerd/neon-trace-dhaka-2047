class_name HackPuzzleBase
extends RefCounted

var title: String = "HACK PUZZLE"
var prompt: String = "Resolve the signal pattern."
var answer: String = ""
var hint: String = "Follow the visible pulse order."

func get_title() -> String:
	return title

func get_prompt() -> String:
	return prompt

func get_hint() -> String:
	return hint

func check_solution(attempt: String) -> bool:
	return attempt.strip_edges().to_upper() == answer.to_upper()

func build_for_target(_target: Node) -> void:
	pass
