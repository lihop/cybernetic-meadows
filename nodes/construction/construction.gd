extends Node2D
class_name Construction


signal deconstructed(by)

var constructed := true


func construct():
	constructed = true


func deconstruct(by):
	constructed = false
	emit_signal("deconstructed", by)
