# SHOP GD

extends Node2D

@export var hamster_wheel : HamsterWheel
@export var upgrades : Array[Upgrade]
@export var upgradeDisplays : Array[UpgradeDisplay]

func _ready() -> void:
	# init all upgrade nodes
	for i in upgradeDisplays.size():
		upgradeDisplays[i].init_display(upgrades[i])
		
	loops_changed(hamster_wheel.loops)

# recieved from wheel signal
func loops_changed(new_loops : float):
	for i in upgradeDisplays.size():
		upgradeDisplays[i].refresh_display(new_loops)

# upgrade, called from button signal, increases lps, or lps mult
# the buttons themselves will increase their level
func _on_upgrade_node_purchased(upgrade_purchase : Upgrade):
	hamster_wheel.loops -= upgrade_purchase.cost
	
	if upgrade_purchase.increase_type == Upgrade.INCREASE_TYPE.Loops_Per_Second:
		hamster_wheel.loopsPerSecond += upgrade_purchase.increase
	else:
		hamster_wheel.loopsPerSecondMlp += upgrade_purchase.increase
