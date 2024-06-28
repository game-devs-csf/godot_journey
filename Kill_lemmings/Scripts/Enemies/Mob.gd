class_name Mob 
extends CharacterBody2D
## Base class for the enemies

enum state {Idle, Running, Attacking}
enum directions {Left, Right}

@export var mob_name = "Mob"
@onready var _animated_sprite = $AnimatedSprite2D
@export var target : Vector2
@export var max_hp := 10

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hp : int = 10:
	set(value): hp = clamp(value, 0, max_hp)
	
var _current_state : state = state.Idle:
	set(value):
		_current_state = value
		set_animation()

var _current_direction : directions = directions.Right:
	set(value):
		_current_direction = value
		if value == directions.Left:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
var att : int = 1
var def : int = 5
var speed : float = 3000
var dead : bool = false
var on_target : bool = false
var _animations : Array[String] = ['Idle', 'Run', 'Attack']

func _ready():
	set_animation()
	
func _process(_delta):
	if !on_target:
		if _current_state != state.Running:	_current_state = state.Running
		
		
		if global_position.distance_to(target) <= 3:
			on_target = true
			_current_state = state.Idle
			
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	velocity.y += gravity * delta
	
	move_towards_target(delta)

func set_animation() -> void:
	_animated_sprite.play(_animations[_current_state])
	
func move_towards_target(delta) -> void:
	var direction = global_position.direction_to(target)
	
	if direction.x < 0:
		_current_direction = directions.Left
		
	if direction.x > 0:
		_current_direction = directions.Right
		
	velocity.x = direction.x * speed * delta
	move_and_slide()
	
func take_damage(value : int) -> void:
	hp -= value
	if hp <= 0:
		dead = true
	
