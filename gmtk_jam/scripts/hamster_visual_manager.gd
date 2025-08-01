class_name HamsterVisualManager
extends Node2D

@export var visuals: Array[HamsterVisual] = []   # “rows” in the inspector
@export var hamsterSprite : Sprite2D

func enable_visual(ind : int, ind2 : int, enable : bool):
	if visuals==null or visuals.is_empty() or ind < 0 or ind >= visuals.size():
		return
		
	if visuals[ind].sprites==null or visuals[ind].sprites.is_empty() or ind2 < 0 or ind2 >= visuals[ind].sprites.size():
		return
		
	var sprite_node_path : NodePath = visuals[ind].sprites[ind2]
	if has_node(sprite_node_path):
		var sprite_node : Sprite2D = get_node(sprite_node_path)
		if sprite_node:
			sprite_node.visible = enable
	
	if visuals[ind].useCustomHamsterColor:
		hamsterSprite.modulate = visuals[ind].customHamsterColor

func _ready() -> void:
	pass
