extends Crafting
class_name CraftingMachine
# A machine capable of crafting. Requires an energy source in order to do this.


export(float) var energy_usage := 0.0
export(NodePath) var energy_source_path

onready var energy_source = get_node(energy_source_path)


func _ready() -> void:
	self.connect("started", self, "_on_started")
	self.connect("stopped", self, "_on_stopped")
	energy_source.connect("depleted", self, "set_on", [false])
	energy_source.connect("refueled", self, "set_on", [true])
	self.on = energy_source.energy > 0


func _on_started() -> void:
	energy_source.energy_usage = energy_usage


func _on_stopped() -> void:
	energy_source.energy_usage = 0
