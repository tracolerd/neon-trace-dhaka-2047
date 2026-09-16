class_name DoorInteractable
extends Interactable

@export var open_rotation := Vector3(0.0, -90.0, 0.0)
@export var close_rotation := Vector3.ZERO
@export var is_open := false

@onready var pivot: Node3D = $Pivot

func _ready() -> void:
	super._ready()
	if pivot != null:
		pivot.rotation_degrees = close_rotation

func can_interact(_player: Node3D) -> bool:
	return true

func interact(_player: Node3D) -> void:
	is_open = not is_open
	if pivot == null:
		return
	var target_rotation := open_rotation if is_open else close_rotation
	var tween := create_tween()
	tween.tween_property(pivot, "rotation_degrees", target_rotation, 0.25)

func get_interaction_prompt() -> String:
	return "[E] %s DOOR" % ("CLOSE" if is_open else "OPEN")

func get_interaction_priority() -> float:
	return 15.0
