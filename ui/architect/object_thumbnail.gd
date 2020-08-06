tool
extends Button


export(String) var object_name = "Object Name" setget set_object_name
export(Texture) var image = null setget set_image
export(PackedScene) var scene


func set_object_name(p_object_name: String) -> void:
	$Label.text = p_object_name
	object_name = p_object_name


func set_image(texture: Texture) -> void:
	var data = texture.get_data()
	data.resize($Image.rect_size.x, $Image.rect_size.y)
	var resized_texture = ImageTexture.new()
	resized_texture.create_from_image(data)
	$Image.texture = resized_texture
	image = resized_texture


func _on_ObjectThumbnail_pressed() -> void:
	var object = scene.instance()
	object.blueprint = true
	object.placed = false
	$"/root/World".add_child(object)
