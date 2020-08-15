extends Popup


export(NodePath) onready var inventory


func _ready():
	#$HBoxContainer/Inventory.inventory = get_node(inventory)
	
	# TODO: Remember position in player preferences.
	set_position(Vector2(166, 166))
	set_size(Vector2(266, 130))
