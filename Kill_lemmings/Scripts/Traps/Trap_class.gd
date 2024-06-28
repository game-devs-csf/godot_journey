class_name Trap

extends Node2D 

 
@export_enum("Box", "Pit", "Spikes") var Trap_type : int

@export var healt : int
@export var Damage : int
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")





