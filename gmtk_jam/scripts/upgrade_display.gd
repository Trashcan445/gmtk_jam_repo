class_name UpgradeDisplay
extends Node

@export var nameDisplay : Label
@export var descDisplay : Label
@export var levelDisplay : Label
@export var button : Button
signal purchased(upgrade : Upgrade)
var info : Upgrade


func init_display(upgradeInfo : Upgrade) -> void:
	info = upgradeInfo
	nameDisplay.text = info.name
	descDisplay.text = "+" + String.num(info.lpsIncrease, 2) + " LPS"
	
	if info.currentLevel==0:
		levelDisplay.text = "NEW "
	else:
		levelDisplay.text = "Lv. " + str(info.currentLevel)
	
	button.text = str(info.cost)
	
func refresh_display(loops : float) -> void:
	button.disabled = loops < info.cost

func purchase_upgrade() -> void:
	purchased.emit(info) # This tells shop to subtract the cost from loops
	info.currentLevel+=1
	button.text = str(info.cost)
