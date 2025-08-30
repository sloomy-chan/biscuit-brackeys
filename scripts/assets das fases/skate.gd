extends Area2D

@onready var musica = get_node("/root/level 4/AudioStreamPlayer")
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.roller_mode = true
		self.queue_free()
		musica.play()
		
	
