class_name PlayerInteraction
extends Node

@onready var interaction_component: InteractionComponent = $InteractionComponent

func try_interact() -> void:
	if interaction_component != null:
		interaction_component.try_interact()
