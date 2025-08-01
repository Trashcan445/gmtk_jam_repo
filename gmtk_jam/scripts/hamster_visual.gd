# HAMSTER VISUAL GD

# VisualList.gd
class_name HamsterVisual
extends Resource

@export var sprites: Array[NodePath] = []   # paths to Sprite2D nodes
@export var useCustomHamsterColor : bool = false
@export var customHamsterColor : Color = Color.GREEN
