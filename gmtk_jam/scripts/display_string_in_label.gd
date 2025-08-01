extends Label

@export var prefix : String = ""
@export var suffix : String = ""


func _on_new_float(new_float: float) -> void:
	text = prefix + String.num(new_float, 2) + suffix
