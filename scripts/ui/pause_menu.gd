extends Control
## Pause flow entry point for the in-game menu.

@onready var developer_info: Control = $DeveloperInfo
var menu_panel: PanelContainer
var developer_button: Button

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_menu()
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") or (event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE):
		if developer_info.visible:
			developer_info.hide_panel()
		elif visible:
			resume_game()
		else:
			open_menu()
		get_viewport().set_input_as_handled()

func open_menu() -> void:
	visible = true
	get_tree().paused = true
	focus_pause_menu()

func resume_game() -> void:
	visible = false
	get_tree().paused = false

func focus_pause_menu() -> void:
	if developer_button != null:
		developer_button.grab_focus()

func _build_menu() -> void:
	var backdrop := ColorRect.new()
	backdrop.color = Color(0.01, 0.02, 0.04, 0.86)
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	backdrop.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(backdrop)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	margin.custom_minimum_size = Vector2(400, 300)
	margin.add_theme_constant_override("margin_left", 32)
	margin.add_theme_constant_override("margin_top", 28)
	margin.add_theme_constant_override("margin_right", 32)
	margin.add_theme_constant_override("margin_bottom", 28)
	add_child(margin)

	menu_panel = PanelContainer.new()
	menu_panel.add_theme_stylebox_override("panel", _panel_style())
	margin.add_child(menu_panel)

	var menu := VBoxContainer.new()
	menu.add_theme_constant_override("separation", 16)
	menu_panel.add_child(menu)

	var title := Label.new()
	title.text = "PAUSED"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 30)
	title.add_theme_color_override("font_color", Color(0.35, 0.95, 1.0))
	menu.add_child(title)

	var resume := Button.new()
	resume.text = "Resume"
	resume.focus_mode = Control.FOCUS_ALL
	resume.pressed.connect(resume_game)
	menu.add_child(resume)

	developer_button = Button.new()
	developer_button.text = "Developer Info"
	developer_button.tooltip_text = "View developer profile and contact links"
	developer_button.focus_mode = Control.FOCUS_ALL
	developer_button.pressed.connect(developer_info.show_panel)
	menu.add_child(developer_button)

	var hint := Label.new()
	hint.text = "Esc / Pause: close menu"
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.add_theme_color_override("font_color", Color(0.65, 0.76, 0.84))
	menu.add_child(hint)

func _panel_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.04, 0.09, 0.14, 0.98)
	style.border_color = Color(0.15, 0.82, 0.94, 0.85)
	style.set_border_width_all(2)
	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_left = 12
	style.corner_radius_bottom_right = 12
	return style
