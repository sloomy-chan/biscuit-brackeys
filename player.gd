extends RigidBody2D

var velocidade = 30
@export var velocidade_ground: float
@export var velocidade_ar: float

@export var forca_pulo = 20
var timer_pulo: float
@export var timer_pulo_limite: float

func _physics_process(delta: float) -> void:
	#controle básico
	if Input.is_action_pressed("right"):
		self.apply_force(Vector2(velocidade, self.linear_velocity.y))
	elif Input.is_action_pressed("left"):
		self.apply_force(Vector2(-velocidade, self.linear_velocity.y))
	
	if self.linear_velocity.y > 0:
		self.gravity_scale = 0.1
		velocidade = velocidade_ar
	else:
		self.gravity_scale = 0.55
		velocidade = velocidade_ground
	
	#pulo
	if Input.is_action_pressed("jump"):
		timer_pulo += 2 * delta
		if timer_pulo < timer_pulo_limite:
			if self.linear_velocity.x > 0:
				self.apply_impulse(Vector2(self.linear_velocity.x/19,-forca_pulo))
			elif self.linear_velocity.x < 0:
				self.apply_impulse(Vector2(-self.linear_velocity.x/19,-forca_pulo))
		else:
			return
	elif Input.is_action_just_released("jump"):
		timer_pulo = 0
	 
