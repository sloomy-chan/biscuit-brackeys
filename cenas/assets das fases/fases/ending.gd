extends Node2D


func _on_button_pressed() -> void:
	var anim = $AnimationPlayer
	anim.play("fade")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade":
		get_tree().change_scene_to_file("res://cenas/assets das fases/fases/main_menu.tscn")
