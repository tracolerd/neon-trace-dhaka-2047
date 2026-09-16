class_name MissionManager
extends Node

var active_mission: MissionRuntime
var objective_manager: ObjectiveManager = ObjectiveManager.new()
var mission_catalog: Dictionary = {}
var completed_missions: Array[String] = []
var _objective_aliases: Dictionary = {
	"scan_terminal": "scan_terminal",
	"recover_evidence": "recover_evidence",
	"secure_exit": "secure_exit",
	"terminal_hacked": "scan_terminal",
	"evidence_discovered": "recover_evidence",
	"checkpoint_triggered": "secure_exit"
}

func _ready() -> void:
	EventBus.system_ready.emit("MissionManager")
	EventBus.notification_requested.emit("Mission manager online", "system")
	EventBus.evidence_discovered.connect(_on_evidence_discovered)
	EventBus.player_action.connect(_on_player_action)

func register_mission(mission_id: String, title: String = "", description: String = "", objective_ids: Array[String] = []) -> MissionRuntime:
	var runtime := MissionRuntime.new(mission_id, title, description, objective_ids)
	mission_catalog[mission_id] = runtime
	return runtime

func start_mission(mission_id: String) -> MissionRuntime:
	if mission_catalog.has(mission_id):
		active_mission = mission_catalog[mission_id]
	else:
		active_mission = MissionRuntime.new(mission_id)
		mission_catalog[mission_id] = active_mission
	objective_manager.clear()
	for objective_id in active_mission.objective_ids:
		objective_manager.register_objective({
			"id": objective_id,
			"title": objective_id.replace("_", " ").capitalize(),
			"completed": active_mission.completed_objectives.has(objective_id)
		})
	if active_mission.current_objective_id != "":
		EventBus.mission_changed.emit(active_mission.mission_id, active_mission.current_objective_id)
	else:
		EventBus.mission_changed.emit(active_mission.mission_id, "")
	EventBus.notification_requested.emit("Mission started: %s" % active_mission.mission_id, "system")
	if GameManager != null:
		GameManager.current_mission_id = active_mission.mission_id
	return active_mission

func add_objective(objective: Dictionary) -> void:
	if active_mission == null:
		objective_manager.register_objective(objective)
		return
	var objective_id: String = str(objective.get("id", ""))
	if objective_id.is_empty():
		return
	active_mission.register_objective(objective_id)
	objective_manager.register_objective(objective)

func complete_objective(objective_id: String) -> bool:
	if objective_id.is_empty():
		return false
	if objective_manager.complete_objective(objective_id):
		if active_mission != null:
			active_mission.complete_objective(objective_id)
		EventBus.objective_completed.emit(active_mission.mission_id if active_mission != null else "", objective_id)
		EventBus.mission_changed.emit(active_mission.mission_id if active_mission != null else "", objective_id)
		if active_mission != null and active_mission.is_complete():
			finish_mission()
		return true
	return false

func finish_mission() -> void:
	if active_mission == null:
		return
	if not completed_missions.has(active_mission.mission_id):
		completed_missions.append(active_mission.mission_id)
	EventBus.notification_requested.emit("Mission complete: %s" % active_mission.mission_id, "success")
	EventBus.mission_changed.emit(active_mission.mission_id, "completed")
	EventBus.mission_completed.emit(active_mission.mission_id)
	active_mission.is_active = false
	if GameManager != null:
		GameManager.current_mission_id = ""
		GameManager.set_story_flag("mission_complete", true)
		GameManager.set_story_flag("last_completed_mission", active_mission.mission_id)
	if SaveManager != null and SaveManager.has_method("save"):
		SaveManager.save()
	active_mission = null

func get_active_mission_state() -> Dictionary:
	if active_mission == null:
		return {}
	return {
		"mission_id": active_mission.mission_id,
		"title": active_mission.title,
		"description": active_mission.description,
		"current_objective_id": active_mission.current_objective_id,
		"completed_objectives": active_mission.completed_objectives,
		"progress": active_mission.get_progress_text()
	}

func _on_evidence_discovered(evidence_id: String) -> void:
	if active_mission == null:
		return
	var alias: String = str(_objective_aliases.get("evidence_discovered", ""))
	if alias != null and not alias.is_empty():
		complete_objective(alias)
	if evidence_id != "":
		EventBus.notification_requested.emit("Objective progress: evidence recovered // %s" % evidence_id, "system")

func _on_player_action(action_name: String, payload: Dictionary) -> void:
	if active_mission == null:
		return
	var alias: String = str(_objective_aliases.get(action_name, ""))
	if alias != null and not alias.is_empty():
		complete_objective(alias)
	if action_name == "terminal_hacked":
		EventBus.notification_requested.emit("Objective progress: terminal compromised", "success")
	elif action_name == "checkpoint_triggered":
		EventBus.notification_requested.emit("Objective progress: checkpoint reached", "system")