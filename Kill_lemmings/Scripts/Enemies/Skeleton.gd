extends Mob

@onready var enemy_health = $EnemyHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	mob_name = 'Skeleton'
	max_hp = 6
	hp = max_hp
	enemy_health.max_health = max_hp
	print("Skeleton hp: %s"%hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	
func _physics_process(delta):
	super._physics_process(delta)

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var object = area.get_parent()
	if object.is_in_group('Trap'):
		if object.Trap_type == 0:
			print("%s collided with box" % name)
			_current_state = state.Idle

func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	_current_state = state.Running

func _on_mob_damaged(_hp):
	enemy_health.current_health = hp
	
func _on_animated_sprite_2d_animation_finished():
	if _animated_sprite.animation == 'Death':
		queue_free()
