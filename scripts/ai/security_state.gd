class_name SecurityState
extends RefCounted

enum SecurityLevel {
	CALM = 0,
	SUSPICIOUS = 1,
	ALERT = 2,
	LOCKDOWN = 3
}

var intensity: float = 0.0
var level: int = SecurityLevel.CALM
var thresholds: Dictionary = {
	"CALM": 24.0,
	"SUSPICIOUS": 49.0,
	"ALERT": 74.0,
	"LOCKDOWN": 100.0
}

func set_intensity(value: float) -> void:
	intensity = clamp(value, 0.0, 100.0)
	if intensity <= thresholds["CALM"]:
		level = SecurityLevel.CALM
	elif intensity <= thresholds["SUSPICIOUS"]:
		level = SecurityLevel.SUSPICIOUS
	elif intensity <= thresholds["ALERT"]:
		level = SecurityLevel.ALERT
	else:
		level = SecurityLevel.LOCKDOWN

func get_level_name() -> String:
	match level:
		SecurityLevel.CALM:
			return "CALM"
		SecurityLevel.SUSPICIOUS:
			return "SUSPICIOUS"
		SecurityLevel.ALERT:
			return "ALERT"
		SecurityLevel.LOCKDOWN:
			return "LOCKDOWN"
	return "CALM"
