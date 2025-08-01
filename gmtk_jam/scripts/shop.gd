# SHOP GD

extends Node2D

@export var hamster_wheel : HamsterWheel
@export var hamster_vis : HamsterVisualManager
@export var upgrades : Array[Upgrade]
@export var upgradeDisplays : Array[UpgradeDisplay]

func _ready() -> void:
	# init all upgrade nodes
	init_all()
		
	loops_changed(hamster_wheel.loops)

# recieved from wheel signal
func loops_changed(new_loops : float):
	for i in upgradeDisplays.size():
		upgradeDisplays[i].refresh_display(new_loops)

# upgrade, called from button signal, increases lps, or lps mult
# the buttons themselves will increase their level
func _on_upgrade_node_purchased(upgrade_purchase : Upgrade):
	hamster_wheel.loops -= upgrade_purchase.cost
	upgrade_purchase.cost += upgrade_purchase.cost_increase
	
	if upgrade_purchase.increase_type == Upgrade.INCREASE_TYPE.Loops_Per_Second:
		hamster_wheel.loopsPerSecond += upgrade_purchase.increase
	else:
		hamster_wheel.loopsPerSecondMlp += upgrade_purchase.increase
		
	# unlock new upgrades from lps
	init_all()
		
	# enable funny visual
	hamster_vis.enable_visual(upgrades.find(upgrade_purchase), upgrade_purchase.currentLevel, true)

func init_all():
	for i in upgradeDisplays.size():
		upgradeDisplays[i].init_display(upgrades[i], hamster_wheel.trueLPS >= upgrades[i].lps_to_unlock)
