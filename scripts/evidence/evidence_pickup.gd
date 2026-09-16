class_name EvidencePickup
extends Interactable

@export var evidence_id: String = ""
@export var title: String = "EVIDENCE"
@export var description: String = "Recovered file fragment."
@export var category: String = "DOCUMENT"

func _ready() -> void:
	super._ready()
	if title == "EVIDENCE":
		title = evidence_id

func can_interact(_player: Node3D) -> bool:
	return evidence_id != ""

func interact(_player: Node3D) -> void:
	var manager = get_tree().root.get_node_or_null("Game/EvidenceManager")
	if manager != null and manager.has_method("register_entry"):
		var entry := EvidenceEntry.new()
		entry.id = evidence_id
		entry.title = title
		entry.description = description
		entry.category = category
		entry.source = "Recovered"
		entry.mission_id = "00_ghost_signal"
		entry.importance = 1
		entry.discovery_location = global_position.snapped(Vector3.ONE * 0.1).to_string()
		manager.register_entry(entry)
		EventBus.notification_requested.emit("Evidence recovered: %s" % title, "success")
		queue_free()

func get_interaction_prompt() -> String:
	return "[E] COLLECT EVIDENCE"

func get_interaction_priority() -> float:
	return 18.0

func get_scan_category() -> String:
	return "EVIDENCE"

func get_scan_details() -> String:
	return "%s // %s" % [title, category]
