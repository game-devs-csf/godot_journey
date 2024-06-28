extends PanelContainer
class_name Slot
@onready var texture_rect = $TextureRect
@export var Type: String


func _get_drag_data(at_position):
	Global.dragging=true
	var preview_texture = TextureRect.new()
	
	preview_texture.texture= texture_rect.texture
	preview_texture.expand_mode=1
	preview_texture.size=Vector2(30,30)
	
	
	var preview=Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	
	return self
	
func _can_drop_data(_pos, data):
	return data is TextureRect
	
func _drop_data(_pos, data):
		
		pass
		

	
	
