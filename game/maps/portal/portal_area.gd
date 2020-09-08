tool
extends Portal
class_name PortalArea
# A portal which a character simply has to enter in order to use.


export(Vector2) var extents: Vector2 setget set_extents


func set_extents(p_extents: Vector2) -> void:
	extents = p_extents
	$CollisionShape2D.shape.extents = extents


func _on_PortalArea_body_entered(body):
	teleport(body)
