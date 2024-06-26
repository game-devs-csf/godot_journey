extends Area2D




func _on_body_entered(body):
	print("no paso nada")
	if body.is_in_group("Trap"):
		print("no paso nada")
		print("Enemy Died")
		self.queue_free()
	
