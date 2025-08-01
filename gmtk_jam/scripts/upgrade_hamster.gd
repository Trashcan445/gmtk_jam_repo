# HAMSTER UPGRADE GD

extends Resource
class_name Upgrade
@export var name : String = "Unnamed Upgrade"
@export var increase : float = 0.1
@export var increase_type : INCREASE_TYPE = INCREASE_TYPE.Loops_Per_Second
@export var costs : Array[int] = []
@export var currentLevel : int = 0

enum INCREASE_TYPE{
	Loops_Per_Second,
	Loops_Per_Second_Mult
}

var cost: int:
	get:
		if costs == null or costs.is_empty():
			return 1
		elif currentLevel >= costs.size():
			return costs[costs.size() - 1]
		else:
			return costs[currentLevel]
