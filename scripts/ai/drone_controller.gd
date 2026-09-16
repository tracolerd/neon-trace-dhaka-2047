class_name DroneController
extends Node3D

enum DroneState {
	PATROL,
	SCAN,
	INVESTIGATE,
	PURSUE,
	SEARCH,
	RETURN,
	DISABLED
}

var current_state: int = DroneState.PATROL
var patrol_points: Array[Vector3] = []

func _ready() -> void:
	add_to_group("drone")

func set_state(state: int) -> void:
	current_state = state
