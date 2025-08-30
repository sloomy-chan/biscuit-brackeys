extends Node2D


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/assets das fases/opening_cutscene.tscn")



func _on_about_pressed() -> void:
	var about = $TextureRect
	if about.is_visible():
		about.visible = false
	else:
		about.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
