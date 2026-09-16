extends Control
## Accessible developer information panel with explicit link-open error reporting.

const DEVELOPER_PHOTO := "res://assets/developer/nurul-faiyaz.jpg"
const LINKS := [
	["Facebook", "https://www.facebook.com/faiyaz.888"],
	["Instagram", "https://www.instagram.com/tracolerd"],
	["LinkedIn", "https://www.linkedin.com/in/faiyaz-xyz"],
	["Twitter / X", "https://x.com/faiyaz_explores"],
	["GitHub", "https://github.com/tracolerd"],
	["Email", "mailto:scrollfaiyaz@gmail.com"],
	["Website", "https://nurul-faiyaz.netlify.app/"],
]

var error_label: Label
var first_link: LinkButton

func _ready() -> void:
	_build_ui()
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_key_input(event: InputEvent) -> void:
	if not visible or not event.pressed:
		return
	if event.keycode == KEY_ESCAPE or event.keycode == KEY_BACK:
		hide_panel()
		get_viewport().set_input_as_handled()

func show_panel() -> void:
	visible = true
	if first_link != null:
		first_link.grab_focus()

func hide_panel() -> void:
	visible = false
	var parent_menu := get_parent()
	if parent_menu != null and parent_menu.has_method("focus_pause_menu"):
		parent_menu.focus_pause_menu()

func _build_ui() -> void:
	var backdrop := ColorRect.new()
	backdrop.color = Color(0.01, 0.02, 0.04, 0.94)
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	backdrop.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(backdrop)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	margin.custom_minimum_size = Vector2(720, 560)
	margin.add_theme_constant_override("margin_left", 34)
	margin.add_theme_constant_override("margin_top", 28)
	margin.add_theme_constant_override("margin_right", 34)
	margin.add_theme_constant_override("margin_bottom", 28)
	add_child(margin)

	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", _panel_style(Color(0.04, 0.09, 0.14, 0.98), Color(0.15, 0.82, 0.94, 0.85)))
	margin.add_child(panel)

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 14)
	panel.add_child(content)

	var title := Label.new()
	title.text = "DEVELOPER INFO"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_color_override("font_color", Color(0.35, 0.95, 1.0))
	title.add_theme_font_size_override("font_size", 30)
	content.add_child(title)

	var subtitle := Label.new()
	subtitle.text = "NEON//TRACE: DHAKA 2047"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_color_override("font_color", Color(0.7, 0.82, 0.9))
	content.add_child(subtitle)

	var photo := TextureRect.new()
	photo.custom_minimum_size = Vector2(150, 150)
	photo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	photo.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	photo.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	if ResourceLoader.exists(DEVELOPER_PHOTO):
		photo.texture = load(DEVELOPER_PHOTO)
	else:
		push_error("DeveloperInfo: developer photo asset is missing: %s" % DEVELOPER_PHOTO)
		var missing := Label.new()
		missing.text = "Developer photo unavailable"
		missing.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		content.add_child(missing)
	content.add_child(photo)

	var name_label := Label.new()
	name_label.text = "Nurul Faiyaz"
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_label.add_theme_color_override("font_color", Color(0.95, 0.98, 1.0))
	name_label.add_theme_font_size_override("font_size", 24)
	content.add_child(name_label)

	var links_grid := GridContainer.new()
	links_grid.columns = 2
	links_grid.add_theme_constant_override("h_separation", 28)
	links_grid.add_theme_constant_override("v_separation", 8)
	content.add_child(links_grid)
	for link_data in LINKS:
		var link := LinkButton.new()
		link.text = link_data[0]
		link.tooltip_text = "Open %s in your browser" % link_data[0]
		link.focus_mode = Control.FOCUS_ALL
		link.pressed.connect(_open_link.bind(link_data[1], link_data[0]))
		links_grid.add_child(link)
		if first_link == null:
			first_link = link

	error_label = Label.new()
	error_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	error_label.add_theme_color_override("font_color", Color(1.0, 0.48, 0.48))
	error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content.add_child(error_label)

	var close_button := Button.new()
	close_button.text = "Back to Pause Menu  [Esc]"
	close_button.focus_mode = Control.FOCUS_ALL
	close_button.pressed.connect(hide_panel)
	close_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	content.add_child(close_button)

func _open_link(url: String, label: String) -> void:
	error_label.text = ""
	var error := OS.shell_open(url)
	if error != OK:
		var message := "Could not open %s. Please check your device browser or network settings." % label
		error_label.text = message
		push_error("DeveloperInfo: failed to open %s (%s): %s" % [url, label, error])

func _panel_style(fill: Color, border: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.set_border_width_all(2)
	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_left = 12
	style.corner_radius_bottom_right = 12
	return style
