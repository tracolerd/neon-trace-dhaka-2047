class_name PlayerState
extends Node

enum MovementState {
	IDLE,
	WALK,
	RUN,
	SPRINT,
	CROUCH,
	JUMP,
	FALL
}

var movement_state: MovementState = MovementState.IDLE
var is_grounded := false
var is_interacting := false
var is_hacking := false

func set_movement_state(next_state: MovementState) -> void:
	if movement_state == next_state:
		return
	movement_state = next_state
	EventBus.player_action.emit("movement_state_changed", {
		"state": MovementState.keys()[movement_state]
	})
