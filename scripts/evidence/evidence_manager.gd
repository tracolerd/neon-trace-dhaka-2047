class_name EvidenceManager
extends Node

var discovered_evidence_ids: Array[String] = []
var database: EvidenceDatabase = EvidenceDatabase.new()

func _ready() -> void:
	EventBus.notification_requested.emit("Evidence manager online", "system")

func register_entry(entry: EvidenceEntry) -> bool:
	if entry == null:
		return false
	database.add_entry(entry)
	if not discovered_evidence_ids.has(entry.id):
		discovered_evidence_ids.append(entry.id)
	EventBus.evidence_discovered.emit(entry.id)
	return true

func has_discovered(entry_id: String) -> bool:
	return discovered_evidence_ids.has(entry_id)

func get_all() -> Array[EvidenceEntry]:
	return database.entries

func get_entry(entry_id: String) -> EvidenceEntry:
	return database.get_entry_by_id(entry_id)

func list_ids() -> Array[String]:
	return discovered_evidence_ids.duplicate()
