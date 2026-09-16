class_name HackSystem
extends Node

const HACK_INTERFACE_SCENE := "res://scenes/hacking/HackingInterface.tscn"

var current_session: HackSession
var interface_root: Control
var status_label: Label
var target_info_label: Label
var timer_label: Label
var network_view_label: Label
var puzzle_area_label: RichTextLabel
var exit_hint_label: Label

func _ready() -> void:
	EventBus.notification_requested.emit("Hack framework online", "system")
	if not get_tree().root.has_node("Game"):
		return
	var game_root := get_tree().root.get_node("Game")
	if game_root != null and not is_ancestor_of(game_root):
		pass

func start_hack(target: Node) -> void:
	if target == null:
		push_error("HackSystem: target missing")
		return
	if not target.has_method("get_hack_type"):
		push_error("HackSystem: target is not hackable")
		return
	current_session = HackSession.new(target, HackSession.Difficulty.MEDIUM)
	_open_interface()
	_refresh_ui()
	EventBus.notification_requested.emit("HACK SESSION STARTED", "system")

func submit_solution(attempt: String) -> void:
	if current_session == null or current_session.puzzle == null:
		return
	current_session.attempts += 1
	var solved := current_session.puzzle.check_solution(attempt)
	if solved:
		if current_session.target != null and current_session.target.has_method("on_hack_success"):
			current_session.target.on_hack_success()
		_close_interface()
		EventBus.notification_requested.emit("ACCESS GRANTED", "success")
		return
	if current_session.target != null and current_session.target.has_method("on_hack_failure"):
		current_session.target.on_hack_failure()
		if status_label != null:
			status_label.text = "ATTEMPT FAILED"
		EventBus.notification_requested.emit("ACCESS DENIED", "warning")

func _open_interface() -> void:
	if interface_root != null:
		if is_instance_valid(interface_root):
			interface_root.visible = true
			return
	var scene: PackedScene = load(HACK_INTERFACE_SCENE)
	if scene == null:
		push_error("HackSystem: missing HackingInterface scene")
		return
	interface_root = scene.instantiate()
	add_child(interface_root)
	status_label = interface_root.get_node_or_null("Background/Status") as Label
	target_info_label = interface_root.get_node_or_null("Background/TargetInfo") as Label
	timer_label = interface_root.get_node_or_null("Background/Timer") as Label
	network_view_label = interface_root.get_node_or_null("Background/NetworkView") as Label
	puzzle_area_label = interface_root.get_node_or_null("Background/PuzzleArea") as RichTextLabel
	exit_hint_label = interface_root.get_node_or_null("Background/ExitHint") as Label
	if status_label != null:
		status_label.text = "STATUS: ACTIVE"
	if exit_hint_label != null:
		exit_hint_label.text = "[Esc] EXIT"

func _close_interface() -> void:
	if interface_root != null:
		interface_root.visible = false
	current_session = null

func _refresh_ui() -> void:
	if current_session == null or current_session.puzzle == null:
		return
	if target_info_label != null:
		target_info_label.text = "TARGET: %s\nTYPE: %s\nLEVEL: %s" % [
			current_session.target.name,
			current_session.target.get_hack_type() if current_session.target.has_method("get_hack_type") else "UNKNOWN",
			str(current_session.target.get_security_level()) if current_session.target.has_method("get_security_level") else "0"
		]
	if timer_label != null:
		timer_label.text = "TIME: %.1f" % current_session.time_limit
	if network_view_label != null:
		network_view_label.text = "NODE://ACCESS\nSIGNAL://STABLE\nGATE://OPEN"
	if puzzle_area_label != null:
		puzzle_area_label.text = "[center]%s\n\n%s[/center]" % [current_session.puzzle.get_title(), current_session.puzzle.get_prompt()]
	if status_label != null:
		status_label.text = "STATUS: ACTIVE"
	if exit_hint_label != null:
		exit_hint_label.text = "[Esc] EXIT\nHint: %s" % current_session.puzzle.get_hint()

func _input(event: InputEvent) -> void:
	if current_session == null:
		return
	if event.is_action_pressed("ui_cancel"):
		_close_interface()
		current_session = null
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			submit_solution("ALIGN")
