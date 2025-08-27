extends Node2D

@onready var anim = $AnimationPlayer

func _ready() -> void:
	match self.name:
		"up-down":
			anim.play("up-down")
		"down-up":
			anim.play("down-up")
		"right-left":
			anim.play("right-left")
		"left-right":
			anim.play("left-right")
