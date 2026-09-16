class_name CheckpointManager
extends Node

const CHECKPOINT_TRIGGERS := [
	"mission_started",
	"major_objective_completed",
	"critical_story_event",
	"major_evidence_discovered",
	"mission_completed"
]

var current_checkpoint: String = ""
var checkpoint_history: Array[String] = []

func trigger(trigger_name: String) -> void:
	if trigger_name not in CHECKPOINT_TRIGGERS:
		push_warning("CheckpointManager: unsupported trigger %s" % trigger_name)
		return
	current_checkpoint = trigger_name
	if not checkpoint_history.has(trigger_name):
		checkpoint_history.append(trigger_name)
	EventBus.player_action.emit("checkpoint_triggered", {"checkpoint": trigger_name, "history": checkpoint_history})
	EventBus.notification_requested.emit("Checkpoint reached: %s" % trigger_name, "system")

func reset() -> void:
	current_checkpoint = ""
	checkpoint_history.clear()
