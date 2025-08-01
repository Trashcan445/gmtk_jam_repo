# HAMSTER WHEEL GD
class_name HamsterWheel
extends Node

# Variables
@export var animplayer : AnimationPlayer
@export var loopAnimationName : String

@export var loops : float = 0.0:
	set(value):
		loops = value
		loops_changed.emit(loops)
		
@export var loopsPerSecond : float = 1.0:
	set(value):
		loopsPerSecond = value
		lps_changed.emit(loopsPerSecond)
		

signal loops_changed(new_loops : float)
signal lps_changed(new_lps : float)
# END variables

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animplayer.play(loopAnimationName)
	animplayer.speed_scale = 0
	lps_changed.emit(loopsPerSecond)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	loops += delta * loopsPerSecond

	var moduloLoops = fposmod(loops, 1.0) # 'Loops' loops between 0 and 1
	animplayer.seek(moduloLoops)


func _on_button_pressed() -> void:
	loopsPerSecond+=0.1
