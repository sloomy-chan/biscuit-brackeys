extends Node2D

var player
var velocidade = 0.3
func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")

func _physics_process(delta: float) -> void:
	for node in player:
		self.position = self.position.lerp(node.position, velocidade * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.queue_free()
