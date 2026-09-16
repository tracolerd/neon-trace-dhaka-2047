class_name PlayerCamera
extends Node3D

@export var target_path: NodePath
@export var distance := 5.5
@export var height := 2.2
@export var position_smoothing := 10.0
@export var rotation_smoothing := 12.0
@export var sensitivity := 0.012
@export var min_pitch := -0.65
@export var max_pitch := 0.45

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var target: Node3D = get_node_or_null(target_path)
var yaw := 0.0
var pitch := -0.15

func _ready() -> void:
	spring_arm.spring_length = distance
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		yaw -= event.relative.x * sensitivity
		pitch = clamp(pitch - event.relative.y * sensitivity, min_pitch, max_pitch)
	elif event.is_action_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if target == null:
		return
	global_position = global_position.lerp(target.global_position + Vector3.UP * height, position_smoothing * delta)
	rotation.y = lerp_angle(rotation.y, yaw, rotation_smoothing * delta)
	rotation.x = lerp_angle(rotation.x, pitch, rotation_smoothing * delta)
