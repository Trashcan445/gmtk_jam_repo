# HAMSTER UPGRADE GD

extends Resource
class_name Upgrade
@export var name : String = "Unnamed Upgrade"
@export var increase : float = 0.1
@export var increase_type : INCREASE_TYPE = INCREASE_TYPE.Loops_Per_Second
@export var cost : int = 1
@export var cost_increase : int = 1
@export var lps_to_unlock : float = 0.0
var currentLevel : int = 0

enum INCREASE_TYPE{
	Loops_Per_Second,
	Loops_Per_Second_Mult
}
