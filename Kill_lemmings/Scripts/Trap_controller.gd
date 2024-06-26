extends Area2D


func _on_body_entered(body):
	if body.is_in_group('Enemy'):
		print("you died")
		
		body.get_node("CollisionShape2D").queue_free()
	
