class_name UpgradeDisplay
extends Node2D

@export var nameDisplay : Label
@export var descDisplay : Label
@export var levelDisplay : Label
@export var button : Button
signal purchased(upgrade : Upgrade)
var info : Upgrade


func init_display(upgradeInfo : Upgrade, _visible : bool = true) -> void:
	info = upgradeInfo
	nameDisplay.text = info.name
		
	if info.currentLevel==0:
		levelDisplay.text = "NEW "
	else:
		levelDisplay.text = "Lv. " + str(info.currentLevel)
	
	if info.cost > 1:
		button.text = str(info.cost)
	else:
		button.text = "Loops Cost: 1"
	
	visible = _visible
	
func refresh_display(loops : float) -> void:
	button.disabled = loops < info.cost

func purchase_upgrade() -> void:
	purchased.emit(info) # This tells shop to subtract the cost from loops
	init_display(info)
	
func lps_changed(myLPS : float, lpsMlp : float) -> void:
	if info.increase_type == Upgrade.INCREASE_TYPE.Loops_Per_Second:
		var inc = String.num(info.increase * lpsMlp, 2)
		descDisplay.text = "+" + inc + " LPS" + " (Total: " + String.num(myLPS, 2) + ")"
	else:
		descDisplay.text = "+" + str((int(info.increase*100)) - 100) + "% LPS"
