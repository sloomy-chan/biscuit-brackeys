extends Area2D

@export var proxima_cena: PackedScene
@onready var player = get_tree().get_nodes_in_group("player")

@onready var colisao = $CollisionShape2D
func _process(delta: float) -> void:
	for node in player:
		if node.tem_o_item == true:
			self.visible = true
			colisao.disabled = false
		else:
			self.visible = false
			colisao.disabled = true
			
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body._close_anim()
		
func _next_level():
	get_tree().call_deferred("change_scene_to_packed", proxima_cena)
