class_name TerminalInteractable
extends Interactable

@export var terminal_name := "TERMINAL"
@export var id := "terminal_test"

func can_interact(_player: Node3D) -> bool:
	return true

func interact(_player: Node3D) -> void:
	var system = get_tree().root.get_node_or_null("Game/HackSystem")
	if system != null and system.has_method("start_hack"):
		system.start_hack(self)
		return
	EventBus.notification_requested.emit("%s access online" % terminal_name, "system")
	EventBus.player_action.emit("terminal_used", {"id": id, "terminal_name": terminal_name})

func get_interaction_prompt() -> String:
	return "[E] HACK %s" % terminal_name

func get_interaction_priority() -> float:
	return 20.0

func get_security_level() -> int:
	return 38

func get_hack_type() -> String:
	return "SIGNAL_ALIGNMENT"

func begin_hack(_player: Node) -> void:
	var system = get_tree().root.get_node_or_null("Game/HackSystem")
	if system != null and system.has_method("start_hack"):
		system.start_hack(self)

func on_hack_success() -> void:
	EventBus.notification_requested.emit("%s compromised" % terminal_name, "success")
	EventBus.player_action.emit("terminal_hacked", {"id": id, "terminal_name": terminal_name})

func on_hack_failure() -> void:
	EventBus.notification_requested.emit("%s deterrence triggered" % terminal_name, "warning")

func get_scan_category() -> String:
	return "ELECTRONIC"

func get_scan_details() -> String:
	return "%s // SECURE LINK" % terminal_name
