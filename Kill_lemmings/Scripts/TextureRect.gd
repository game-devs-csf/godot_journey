extends TextureRect


func _get_drag_data(at_position):
	print("supongo que opteniendo objeto")
	var preview_texture= TextureRect.new()
	
	preview_texture.texture=texture
	preview_texture.expand_mode=1
	preview_texture.size= Vector2 (30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	return texture 

func _can_drop_data(at_position, data):
	print("aqui no se que pedo")
	return data is Texture2D
	
func _drop_data(at_position, data):
	var nuevo=Trap.new()
	print("dropenado objeto")
	texture=data
