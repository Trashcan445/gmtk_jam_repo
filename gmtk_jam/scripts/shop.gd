# SHOP GD

extends Node2D

@export var hamster_wheel : HamsterWheel
@export var hamster_vis : HamsterVisualManager
@export var baseLPS : float = 0.1
@export var upgrades : Array[Upgrade]
@export var upgradeDisplays : Array[UpgradeDisplay]

signal button_pressed()

func _ready() -> void:
	# init all upgrade nodes
	init_all()
	
	calc_lps()
		
	loops_changed(hamster_wheel.loops)

# recieved from wheel signal
func loops_changed(new_loops : float):
	for i in upgradeDisplays.size():
		upgradeDisplays[i].refresh_display(new_loops)

# upgrade, called from button signal, increases lps, or lps mult
# the buttons themselves will increase their level
func _on_upgrade_node_purchased(upgrade_purchase : Upgrade):
	hamster_vis.enable_visual(upgrades.find(upgrade_purchase), upgrade_purchase.currentLevel, true)# enable funny visual
	
	hamster_wheel.loops -= upgrade_purchase.cost
	upgrade_purchase.cost += upgrade_purchase.cost_increase
	upgrade_purchase.cost_increase = upgrade_purchase.cost_increase * 1.5
	upgrade_purchase.currentLevel += 1
	
	calc_lps()
		
	init_all()# unlock new upgrades from lps
	button_pressed.emit()

func init_all():
	for i in upgradeDisplays.size():
		upgradeDisplays[i].init_display(upgrades[i], hamster_wheel.loopsPerSecond >= upgrades[i].lps_to_unlock-0.0001)

func calc_lps():
	var lpsMlp : float = 1.0
	var totalLPS : float = baseLPS
	
	for i in range(upgrades.size()):
		var upgrade = upgrades[i]
		if upgrade.increase_type == Upgrade.INCREASE_TYPE.Loops_Per_Second_Mult:
			if upgrade.currentLevel > 0:
				lpsMlp *= pow(upgrade.increase, upgrade.currentLevel)
			upgradeDisplays[i].lps_changed(0, lpsMlp)
				
	for i in range(upgrades.size()):
		var upgrade = upgrades[i]
		if upgrade.increase_type == Upgrade.INCREASE_TYPE.Loops_Per_Second:
			if upgrade.currentLevel > 0:
				var lpsFromThisUpgrade = upgrade.increase * lpsMlp * upgrade.currentLevel
				totalLPS += lpsFromThisUpgrade
				upgradeDisplays[i].lps_changed(lpsFromThisUpgrade, lpsMlp)
			else:
				upgradeDisplays[i].lps_changed(0, lpsMlp)
			
	hamster_wheel.loopsPerSecond = totalLPS
