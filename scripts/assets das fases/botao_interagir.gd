extends Node2D

@onready var temporizador_botoes = $Area2D/Timer
@export var plataformas: Array[Node2D]

@onready var sprite = $Area2D/sprite2d

func _process(delta: float) -> void:
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
		temporizador_botoes.start()
