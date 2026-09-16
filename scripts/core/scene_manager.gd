extends Node
## Single boundary for validated scene changes.
signal transition_started(target_path: String)
signal transition_finished(target_path: String)

func _ready() -> void:
	EventBus.system_ready.emit("SceneManager")

func change_scene(target_path: String) -> void:
	if target_path.is_empty():
		push_error("SceneManager: empty target path")
		return
	if not ResourceLoader.exists(target_path):
		push_error("SceneManager: scene does not exist: %s" % target_path)
		return
	transition_started.emit(target_path)
	var error := get_tree().change_scene_to_file(target_path)
	if error != OK:
		push_error("SceneManager: failed to change scene (%s): %s" % [error, target_path])
		return
	transition_finished.emit(target_path)

func reload_current_scene() -> void:
	var current_scene := get_tree().current_scene
	if current_scene != null and current_scene.scene_file_path != "":
		change_scene(current_scene.scene_file_path)
	else:
		push_warning("SceneManager: no active scene to reload")
