extends Area2D
@onready var spikes = $".."


func _on_body_entered(body):
	body.health-=spikes.Damage
	
