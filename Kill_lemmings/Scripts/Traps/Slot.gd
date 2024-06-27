extends PanelContainer
class_name Slot
@onready var texture_rect = $TextureRect
@export var scene:PackedScene

@export_enum("NONE :0", "PASSIVE:1", "INVENTORY:2") var slot_type : int

func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	
	preview_texture.texture= texture_rect.texture
	preview_texture.expand_mode=1
	preview_texture.size=Vector2(30,30)
	
	
	var preview=Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	
	return texture_rect
	
func _can_drop_data(_pos, data):
	return data is TextureRect
	
func _drop_data(_pos, data):
		
		var instance=scene.instantiate()
		var pos_ref = get_global_position() + Vector2(20, 20)
		instance.global_position=pos_ref
		add_sibling(instance)
		
func get_preview():
	var preview_texture = TextureRect.new()
	
	preview_texture.texture=texture_rect.texture
	preview_texture.expand_mode=1
	preview_texture.size=Vector2(30,30)
	
	
	var preview=Control.new()
	preview.add_child(preview_texture)
	
	
	return preview
	
	
