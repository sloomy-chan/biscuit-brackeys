extends Area2D

@export var proxima_cena: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("change_scene_to_packed", proxima_cena)
