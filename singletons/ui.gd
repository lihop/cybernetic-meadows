extends Node


var ui_layer := CanvasLayer.new()
var window = null setget set_window


func set_window(new_window):
	# Only allow one window open at a time.
	if window != null:
		window.queue_free()
	window = new_window


func _ready():
	ui_layer.name = "UI"
	$"/root/World".add_child(ui_layer)


func _input(event: InputEvent):
	if event.is_action_pressed("ui_close_window") and window:
		close_window()
		get_tree().set_input_as_handled()


func open_window(window):
	self.window = window
	ui_layer.add_child(window)
	# popup_centered() is used to position the window, but we want to keep it
	# open even when the player clicks outside, therefore we immediately call
	# hide() and show() as show() displays the window non-modally as per:
	# https://godotengine.org/qa/10306/keep-exclusive-windowdialogs-open-when-clicking-outside-them?show=10399#a10399
	window.popup_centered()
	window.hide()
	window.show()


func close_window():
	window.hide()
	ui_layer.remove_child(window)
	window.queue_free()
	self.window = null
