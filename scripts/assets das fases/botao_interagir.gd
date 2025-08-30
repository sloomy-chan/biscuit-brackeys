extends Node2D

@onready var temporizador_botoes = $Area2D/Timer
@export var plataformas: Array[Node2D]

@onready var sprite = $Area2D/sprite2d

@onready var tick_sfx = $"tick tock"
func _process(delta: float) -> void:
	if !temporizador_botoes.is_stopped() && !tick_sfx.is_playing():
		tick_sfx.play()
	for nodes in plataformas:
		if temporizador_botoes.is_stopped():
			nodes.get_node("AnimatableBody2D/CollisionShape2D").disabled = true
			nodes.visible = false
			sprite.animation = "off"
		else:
			nodes.get_node("AnimatableBody2D/CollisionShape2D").disabled = false
			nodes.visible = true
			sprite.animation = "on"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var sfx = $active
		sfx.play()
		temporizador_botoes.start()
