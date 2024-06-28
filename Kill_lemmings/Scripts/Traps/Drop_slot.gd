extends PanelContainer
class_name Drop_slot
@onready var texture_rect = $TextureRect
@export var Box:PackedScene
@export var Pit :PackedScene
@export var Spikes :PackedScene
var Full = false

func _get_drag_data(at_position):
	pass
	
func _can_drop_data(_pos, data):
	return data is Slot
	
func _drop_data(_pos, data):
	if not Full:
		if data.Type=="Box":
			Spawn_Box()
		elif data.Type=="Pit":
			Spawn_Pit()
		elif data.Type=="Spikes":
			Spawn_Spikes()
		Full=true
	else: 
		print("Slot ocupado")
	
func _process(delta):
	if Global.dragging:
		self.visible=true
	else:
		self.visible=false

func Spawn_Box():
	var instance=Box.instantiate()
	var pos_ref = get_global_position() + Vector2(15, 15)
	instance.global_position=pos_ref
	instance.drop_zone = self
	add_sibling(instance)
	Global.dragging=false
	
func Spawn_Pit():
	var instance=Pit.instantiate()
	var pos_ref = get_global_position() + Vector2(15, 15)
	instance.drop_zone = self
	instance.global_position=pos_ref
	add_sibling(instance)
	Global.dragging=false

func Spawn_Spikes():
	var instance=Spikes.instantiate()
	var pos_ref = get_global_position() + Vector2(15, 15)
	instance.drop_zone = self
	instance.global_position=pos_ref
	add_sibling(instance)
	Global.dragging=false
	
	
