extends Area2D
class_name Portal


export(String, FILE, "*.tscn") var scene: String


func teleport(body: PhysicsBody2D) -> void:
	get_tree().change_scene(scene)
