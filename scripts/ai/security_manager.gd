class_name SecurityManager
extends Node

var state: SecurityState = SecurityState.new()
var current_alertness: float = 0.0

func _ready() -> void:
	state.set_intensity(0.0)
	EventBus.notification_requested.emit("Security system online", "system")
	EventBus.security_changed.emit(current_alertness, state.get_level_name())

func add_intensity(amount: float) -> void:
	current_alertness = clamp(current_alertness + amount, 0.0, 100.0)
	state.set_intensity(current_alertness)
	EventBus.security_changed.emit(current_alertness, state.get_level_name())

func set_intensity(value: float) -> void:
	current_alertness = clamp(value, 0.0, 100.0)
	state.set_intensity(current_alertness)
	EventBus.security_changed.emit(current_alertness, state.get_level_name())

func reduce_intensity(amount: float) -> void:
	current_alertness = clamp(current_alertness - amount, 0.0, 100.0)
	state.set_intensity(current_alertness)
	EventBus.security_changed.emit(current_alertness, state.get_level_name())

func get_level_name() -> String:
	return state.get_level_name()

func get_intensity() -> float:
	return state.intensity
