extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var audio = $AudioStreamPlayer2D
		body.tem_o_item = true
		audio.play()
		self.visible = false


func _on_audio_stream_player_2d_finished() -> void:
	self.queue_free()
