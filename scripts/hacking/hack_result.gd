class_name HackResult
extends RefCounted

enum Status {
	SUCCESS,
	FAILURE,
	CANCELLED
}

var status: int = Status.SUCCESS
var message: String = ""
var score: int = 0

func _init(p_status: int = Status.SUCCESS, p_message: String = "", p_score: int = 0) -> void:
	status = p_status
	message = p_message
	score = p_score
