class_name NPCController
extends CharacterBody3D

@export var patrol_points: Array[Vector3] = []
@export var wait_time := 2.0
@export var vision_range := 7.0
@export var vision_angle := 45.0
@export var hearing_range := 5.0
@export var investigation_time := 6.0
@export var search_radius := 5.0

var current_patrol_index := 0
var state_name := "PATROL"
var timer := 0.0

func _ready() -> void:
	if patrol_points.is_empty():
		patrol_points = [global_position, global_position + Vector3(3.0, 0.0, 0.0)]
	add_to_group("npc")

func _physics_process(delta: float) -> void:
	if patrol_points.size() <= 1:
		return
	var target := patrol_points[current_patrol_index]
	var direction := target - global_position
	if direction.length() < 0.5:
		timer += delta
		if timer >= wait_time:
			timer = 0.0
			current_patrol_index = (current_patrol_index + 1) % patrol_points.size()
		return
	velocity = direction.normalized() * 2.0
	move_and_slide()
	state_name = "PATROL"
