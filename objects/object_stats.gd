extends Resource
class_name ObjectResource


export(String) var name
export(Texture) var texture


func _init(p_name: String = "", p_texture: Texture = null):
	name = p_name
	texture = p_texture
