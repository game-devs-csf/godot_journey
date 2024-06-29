extends PanelContainer
class_name Drop_slot
@onready var texture_rect = $TextureRect
@export var Box:PackedScene
@export var Pit :PackedScene
@export var Spikes :PackedScene
@onready var Manager =$"../.."
var Full = false

func _get_drag_data(at_position):
	pass
	
func _can_drop_data(_pos, data):
	return data is Slot
	
func _drop_data(_pos, data):
	if not Full:
		if data.Type=="Box":
			Spawn_Scene(Box)
		elif data.Type=="Pit":
			Spawn_Scene(Pit)
		elif data.Type=="Spikes":
			Spawn_Scene(Spikes)
		Full=true
	else: 
		print("Slot ocupado")
	Global.dragging=false
	
func _process(delta):
	if Global.dragging:
		self.visible=true
		if Input.is_action_just_released("click"):
			Global.dragging=false
	else:
		self.visible=false
		
func Spawn_Scene(Scene :PackedScene):
	var instance=Scene.instantiate()
	
	if Manager._coins<instance.Cost:
		instance.queue_free()
		Global.dragging=false
		print("No coins")
		
	else:
		print("Costo: " + str(instance.Cost))
		var pos_ref = get_global_position() + Vector2(15, 15)
		instance.drop_zone = self
		instance.global_position=pos_ref
		Manager.add_child(instance)
		Manager.add_coins(-instance.Cost, "trap")
	
