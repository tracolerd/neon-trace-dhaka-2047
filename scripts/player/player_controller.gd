class_name PlayerController
extends CharacterBody3D

@export_category("Movement")
@export var walk_speed := 3.5
@export var run_speed := 5.5
@export var sprint_speed := 8.0
@export var crouch_speed := 1.8
@export var jump_velocity := 6.5
@export var acceleration := 18.0
@export var deceleration := 24.0
@export var gravity_scale := 1.0
@export var rotation_speed := 12.0

@onready var state: PlayerState = $Components/PlayerState
@onready var visual_root: Node3D = $VisualRoot
@onready var interaction_component: InteractionComponent = $Components/InteractionComponent
@onready var scanner: PlayerScanner = $Components/PlayerScanner

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	var grounded := is_on_floor()
	state.is_grounded = grounded
	if not grounded:
		velocity.y -= get_gravity().y * gravity_scale * delta
	elif velocity.y < 0.0:
		velocity.y = 0.0

	if Input.is_action_just_pressed("jump") and grounded and not state.is_interacting and not state.is_hacking:
		velocity.y = jump_velocity
		state.set_movement_state(PlayerState.MovementState.JUMP)
	if Input.is_action_just_pressed("interact") and interaction_component != null:
		interaction_component.try_interact()
	if Input.is_action_just_pressed("scanner") and scanner != null:
		scanner.toggle()

	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := Vector3(input_vector.x, 0.0, input_vector.y)
	var target_speed := _get_target_speed(input_vector)
	var target_velocity := direction * target_speed
	var rate := acceleration if direction.length_squared() > 0.0 else deceleration
	velocity.x = move_toward(velocity.x, target_velocity.x, rate * delta)
	velocity.z = move_toward(velocity.z, target_velocity.z, rate * delta)

	if direction.length_squared() > 0.0:
		var target_angle := atan2(direction.x, direction.z)
		visual_root.rotation.y = lerp_angle(visual_root.rotation.y, target_angle, rotation_speed * delta)

	if grounded:
		state.set_movement_state(_get_movement_state(input_vector))
	elif velocity.y < 0.0:
		state.set_movement_state(PlayerState.MovementState.FALL)

	move_and_slide()

func _get_target_speed(input_vector: Vector2) -> float:
	if input_vector.length_squared() == 0.0:
		return 0.0
	if Input.is_action_pressed("crouch"):
		return crouch_speed
	if Input.is_action_pressed("sprint"):
		return sprint_speed
	return run_speed if input_vector.length() > 0.8 else walk_speed

func _get_movement_state(input_vector: Vector2) -> PlayerState.MovementState:
	if input_vector.length_squared() == 0.0:
		return PlayerState.MovementState.IDLE
	if Input.is_action_pressed("crouch"):
		return PlayerState.MovementState.CROUCH
	if Input.is_action_pressed("sprint"):
		return PlayerState.MovementState.SPRINT
	if input_vector.length() > 0.8:
		return PlayerState.MovementState.RUN
	return PlayerState.MovementState.WALK
