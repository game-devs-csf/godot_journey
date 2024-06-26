extends Node2D

const _goblin_path = "res://Scenes/Characters/Enemies/goblin.tscn"
var _enemy_references = []
var _enemies_in_scene = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	load_enemies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func load_enemies():
	var enemy = preload(_goblin_path)
	_enemy_references.append(enemy)
	
func spawn_mobs():
	$EnemySpawnLocations/PathFollow2D.progress_ratio = randf()
	var mob = _enemy_references[randi() % _enemy_references.size()].instantiate()
	mob.target = Vector2(0,0)
	mob.global_position = $EnemySpawnLocations/PathFollow2D.global_position
	_enemies_in_scene.append(mob)
	$Enemies.add_child(mob)

func _on_timer_timeout():
	spawn_mobs() # Replace with function body.
