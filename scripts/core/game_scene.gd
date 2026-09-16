extends Node
## Foundation scene. Gameplay systems are intentionally added milestone by milestone.
@onready var interaction_prompt: Label = $UILayer/InteractionPrompt
@onready var scanner_overlay: Label = $UILayer/ScannerOverlay
@onready var mission_label: Label = $UILayer/MissionStatus
@onready var status_log: RichTextLabel = $UILayer/StatusLog
@onready var ending_label: Label = $UILayer/EndingStatus
@onready var failure_label: Label = $UILayer/FailureStatus
@onready var mission_manager: MissionManager = $MissionManager
@onready var checkpoint_manager: CheckpointManager = $CheckpointManager
@onready var ending_manager: EndingManager = $EndingManager
@onready var failure_manager: FailureManager = $FailureManager
@onready var pause_menu: Control = $UILayer/PauseMenu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	EventBus.notification_requested.connect(_on_notification_requested)
	EventBus.interaction_prompt_changed.connect(_on_interaction_prompt_changed)
	EventBus.scanner_status_changed.connect(_on_scanner_status_changed)
	EventBus.mission_changed.connect(_on_mission_changed)
	EventBus.ending_reached.connect(_on_ending_reached)
	EventBus.mission_failed.connect(_on_mission_failed)
	_on_interaction_prompt_changed("", false)
	_on_scanner_status_changed("SCANNER OFF", false)
	_append_log("NEON//TRACE foundation online")
	_initialize_mission_framework()
	if ending_manager != null:
		ending_manager.resolve_ending_from_state()
	if failure_manager != null:
		failure_manager.set_reset_position(Vector3(0.0, 0.0, 4.0))

func _initialize_mission_framework() -> void:
	if mission_manager == null:
		return
	var intro_mission_id := "mission_01_finding_the_backdoor"
	mission_manager.register_mission(
		intro_mission_id,
		"Finding the Backdoor",
		"Trace the civic relay breach and recover the first compromised signal.",
		["scan_terminal", "recover_evidence", "secure_exit"]
	)
	mission_manager.start_mission(intro_mission_id)
	if checkpoint_manager != null:
		checkpoint_manager.trigger("mission_started")
	_on_mission_changed(intro_mission_id, "scan_terminal")
	_append_log("Mission engaged: Finding the Backdoor")

func _on_interaction_prompt_changed(prompt: String, visible: bool) -> void:
	if interaction_prompt == null:
		return
	interaction_prompt.visible = visible
	interaction_prompt.text = prompt

func _on_scanner_status_changed(summary: String, active: bool) -> void:
	if scanner_overlay == null:
		return
	scanner_overlay.visible = active
	scanner_overlay.text = summary

func _on_mission_changed(mission_id: String, objective_id: String) -> void:
	if mission_label == null:
		return
	if mission_id.is_empty():
		mission_label.text = "MISSION: STANDBY"
		return
	if objective_id == "completed":
		mission_label.text = "MISSION COMPLETE: %s" % mission_id
		_append_log("Mission complete: %s" % mission_id)
		return
	var objective_text := objective_id.replace("_", " ").capitalize()
	mission_label.text = "MISSION: %s\nOBJECTIVE: %s" % [mission_id, objective_text]

func _on_notification_requested(message: String, category: String) -> void:
	_append_log("[%s] %s" % [category.to_upper(), message])

func _on_ending_reached(ending_id: String, title: String) -> void:
	if ending_label == null:
		return
	ending_label.text = "ENDING: %s" % title
	_append_log("Ending resolved: %s" % title)

func _on_mission_failed(mission_id: String, reason: String) -> void:
	if failure_label == null:
		return
	failure_label.text = "FAILURE: %s" % reason.to_upper()
	_failure_reset_hint()
	_append_log("Mission failed: %s // %s" % [mission_id, reason])

func _failure_reset_hint() -> void:
	if failure_label == null:
		return
	failure_label.text = "FAILURE: %s\nRESETTING POSITION" % failure_label.text.replace("FAILURE: ", "").to_upper()
	if failure_manager != null:
		failure_manager.reset_player_position()

func _append_log(entry: String) -> void:
	if status_log == null:
		return
	var existing := status_log.text
	if existing.length() > 0:
		existing = "%s\n%s" % [existing, entry]
	else:
		existing = entry
	status_log.text = existing
	if status_log.has_method("scroll_to_line"):
		status_log.scroll_to_line(status_log.get_line_count() - 1)
