class_name HackSession
extends RefCounted

enum Difficulty {
	EASY,
	MEDIUM,
	HARD,
	EXPERT
}

var target: Node
var difficulty: int = Difficulty.MEDIUM
var time_limit: float = 30.0
var puzzle: HackPuzzleBase
var started_at: float = 0.0
var attempts: int = 0

func _init(p_target: Node = null, p_difficulty: int = Difficulty.MEDIUM) -> void:
	target = p_target
	difficulty = p_difficulty
	puzzle = SignalAlignment.new()
	started_at = Time.get_ticks_msec() / 1000.0
	match difficulty:
		Difficulty.EASY:
			time_limit = 45.0
		Difficulty.MEDIUM:
			time_limit = 30.0
		Difficulty.HARD:
			time_limit = 22.0
		Difficulty.EXPERT:
			time_limit = 16.0
