extends Node2D

var player
var velocidade = 0.5
@onready var audio = $AudioStreamPlayer2D
func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")

func _physics_process(delta: float) -> void:
	for node in player:
		self.position = self.position.lerp(node.position, velocidade * delta)
	if !audio.is_playing():
		audio.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("reload_current_scene")
