class_name Trap

extends Node2D 

signal trap_destroyed

var drop_zone : PanelContainer = null

@export_enum("Box", "Pit", "Spikes") var Trap_type : int
@export var Cost:int

@export var health : int = 10:
	set(value):
		health = clamp(value, 0, 100)
		if health == 0:
			trap_destroyed.emit()

@export var Damage : int

func _on_trap_destroyed():
	if drop_zone != null:
		drop_zone.Full = false
	queue_free()
