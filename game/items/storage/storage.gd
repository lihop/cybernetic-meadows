extends Item2D
class_name Storage


onready var UI: InGameUI = $"/root/World/UI"


func interact_primary(body):
	UI.open_inventory_window($Inventory)

func _on_Reach_body_exited(body):
	print('TODO: Callback for closing the window')
