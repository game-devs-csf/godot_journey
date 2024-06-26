extends Mob

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	mob_name = 'Goblin'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func _physics_process(delta):
	super._physics_process(delta)
