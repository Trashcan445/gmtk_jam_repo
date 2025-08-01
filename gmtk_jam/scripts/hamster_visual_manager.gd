class_name HamsterVisualManager
extends Node2D

@export var visuals: Array[HamsterVisual] = []   # “rows” in the inspector
@export var hamsterSprite : Sprite2D

func enable_visuals(ind : int, ind2 : int, enable : bool):
	var sprite_node_path : NodePath = visuals[ind].sprites[ind2]
	var sprite_node : Sprite2D = get_node(sprite_node_path)
	sprite_node.visible = enable
	
	if visuals[ind].useCustomHamsterColor:
		hamsterSprite.modulate = visuals[ind].customHamsterColor

func _ready() -> void:
	pass
