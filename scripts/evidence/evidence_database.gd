class_name EvidenceDatabase
extends Resource

@export var entries: Array[EvidenceEntry] = []

func add_entry(entry: EvidenceEntry) -> void:
	if entry == null:
		return
	for existing in entries:
		if existing.id == entry.id:
			return
	entries.append(entry)

func get_entry_by_id(entry_id: String) -> EvidenceEntry:
	for entry in entries:
		if entry.id == entry_id:
			return entry
	return null
