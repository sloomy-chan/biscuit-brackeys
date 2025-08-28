extends Node2D

@onready var timer = $Timer
@onready var cooldown = $cooldown
@onready var colisao = $StaticBody2D/CollisionShape2D
@onready var anim = $StaticBody2D/AnimatedSprite2D

func _process(delta: float) -> void:
	if timer.is_stopped():
		anim.pause()
	else:
		anim.play("break")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		timer.start()
		
func _on_timer_timeout() -> void:
	self.visible = false
	colisao.disabled = true
	cooldown.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		timer.stop()


func _on_cooldown_timeout() -> void:
	self.visible = true
	colisao.disabled = false
