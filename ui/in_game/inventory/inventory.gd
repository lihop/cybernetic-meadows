extends Popup


export(NodePath) onready var inventory


func _ready():
	#$HBoxContainer/Inventory.inventory = get_node(inventory)
	
	# TODO: Remember position in player preferences.
	set_position(Vector2(500, 500))
	set_size(Vector2(800, 390))
