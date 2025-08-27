extends Area2D

@onready var temporizador_botoes = $Timer
var ativo = false

var plataformas
func _ready() -> void:
	plataformas = get_tree().get_nodes_in_group("plataforma-some")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && ativo == false:
		temporizador_botoes.start()
		ativo = true

func _process(delta: float) -> void:
	if ativo == true:
		for nodes in plataformas:
			nodes.get_node("AnimatableBody2D/CollisionShape2D").disabled = false
			nodes.visible = true
	else:
		for nodes in plataformas:
			nodes.get_node("AnimatableBody2D/CollisionShape2D").disabled = true
			nodes.visible = false

func _on_timer_timeout() -> void:
	ativo = false
