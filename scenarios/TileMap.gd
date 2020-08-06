tool
extends TileMap


func _ready():
	# warning-ignore:return_value_discarded
	connect("settings_changed", self, "_on_settings_changed")


func _on_settings_changed():
	print('settings changed!')
