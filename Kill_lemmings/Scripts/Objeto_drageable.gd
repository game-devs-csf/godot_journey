extends Node2D
@onready var sprite_2d = $Sprite2D

func _ready():
	# Conectar la señal para detectar cuando se comienza a arrastrar
	sprite_2d.connect("gui_input", self, "_on_Sprite2D_gui_input")

func _on_Sprite2D_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var drag_data = _get_drag_data(sprite_2d.position)
		set_drag_preview(drag_data)

func _get_drag_data(at_position: Vector2):
	var preview_node = Sprite2D.new()
	preview_node.texture = sprite_2d.texture
	preview_node.scale = Vector2(0.3, 0.3)  # Adjust the scale as needed
	
	var preview = Control.new()
	preview.add_child(preview_node)
	
	return preview

func _can_drop_data(at_position: Vector2, data):
	return data is Texture

func _drop_data(at_position: Vector2, data):
	if data is Texture:
		sprite_2d.texture = data
