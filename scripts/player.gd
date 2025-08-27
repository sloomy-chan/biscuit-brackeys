extends CharacterBody2D

var velocidade = 30
@export var velocidade_ground: float
@export var velocidade_ar: float
@export var velocidade_sprint: float
var esta_correndo = false

@export var forca_pulo = 20
var timer_pulo: float
@export var timer_pulo_limite: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	_movimentacao_no_chao(delta)
	_pulo(delta)
	_coyote_time()
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_pressed("sprint"):
		esta_correndo = !esta_correndo
	
	if self.velocity.x == 0:
		esta_correndo = false
	if esta_correndo == true:
		velocidade = velocidade_sprint
	else:
		velocidade = velocidade_ground
	
	print(coyote_timer.time_left)

func _movimentacao_no_chao(delta):
	if Input.is_action_pressed("left"):
		self.velocity.x = -velocidade * delta
	elif Input.is_action_pressed("right"):
		self.velocity.x = velocidade * delta
	else:
		self.velocity.x = 0
	
	if !is_on_floor():
		velocidade = velocidade_ar
	else:
		velocidade = velocidade_ground
		jump_count = 0
	move_and_slide()

@export var jump_count_max: int
var jump_count: int
func _pulo(delta):
	if Input.is_action_pressed("jump") && jump_count < jump_count_max:
		timer_pulo += 2 * delta
		if timer_pulo < timer_pulo_limite:
			self.velocity.y = -forca_pulo
		else:
			jump_count += 1
			self.velocity.y += gravity * delta
	elif Input.is_action_just_released("jump"):
		timer_pulo = 0
		jump_count += 1
		self.velocity.y += gravity * delta

@onready var coyote_timer = $"coyote time"
func _coyote_time():
	if self.velocity.y < 2:
		coyote_timer.start()


func _on_coyote_time_timeout() -> void:
	jump_count += 1
