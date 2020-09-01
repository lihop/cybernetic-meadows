extends Node
class_name EnergySource
# Base class for EnergySources.


signal depleted()
signal refueled()

var energy: float = 0.0 setget set_energy
# The amount of energy at which this energy source is considered to be at 100%.
var energy_scale: float = energy
var energy_usage: float = 0.0 setget set_energy_usage


func set_energy(amount: float) -> void:
	energy = amount
	if energy > 0:
		energy_scale = energy
		emit_signal("refueled")
		if energy_usage > 0:
			set_process(true)


func set_energy_usage(amount: float) -> void:
	energy_usage = amount
	if energy_usage < 0:
		push_error("Invalid energy_usage")
	elif energy_usage == 0:
		set_process(false)
	else:
		set_process(true)


func _process(delta):
	energy = max(0, energy - energy_usage * delta)
	if energy == 0:
		refuel()
		if energy == 0:
			set_process(false)
			emit_signal("depleted")


func refuel():
	pass
