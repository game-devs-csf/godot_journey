class_name Mob 
extends CharacterBody2D

## Base class for the enemies

@export var mob_name = "Mob"
@onready var _animated_sprite = $AnimatedSprite2D
@export var target : Vector2
@export var max_hp := 10

enum state {Idle, Running, Attacking}

var hp : int = 10:
	set(value): hp = clamp(value, 0, max_hp)
	
var _current_state : state = state.Idle:
	set(value):
		_current_state = value
		set_animation()
		
var att : int = 1
var def : int = 5
var speed : float = 300
var dead : bool = false
var on_target : bool = false
var _animations : Array[String] = ['Idle', 'Run', 'Attack']

func _ready():
	set_animation()
	
func _process(delta):
	if !on_target:
		if _current_state != state.Running:	_current_state = state.Running
		move_towards_target()
		if global_position.distance_to(target) <= 3:
			on_target = true
			_current_state = state.Idle

func set_animation() -> void:
	_animated_sprite.play(_animations[_current_state])
	
func move_towards_target() -> void:
	var direction = global_position.direction_to(target)
	velocity = direction * speed
	move_and_slide()
	
func take_damage(value : int) -> void:
	hp -= value
	if hp <= 0:
		dead = true
	
