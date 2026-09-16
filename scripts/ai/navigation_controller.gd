class_name NavigationController
extends Node

var nav_region: NavigationRegion3D

func _ready() -> void:
	nav_region = get_parent().get_node_or_null("NavigationRegion3D") as NavigationRegion3D
	if nav_region != null:
		nav_region.navigation_layers = 1

func request_path(start: Vector3, end: Vector3) -> PackedVector3Array:
	if nav_region == null:
		return PackedVector3Array()
	var map := nav_region.get_world_3d().navigation_map
	if map == null:
		return PackedVector3Array()
	return NavigationServer3D.map_get_path(map, start, end, true)
