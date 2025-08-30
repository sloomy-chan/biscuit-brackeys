extends CharacterBody2D

var velocidade = 30
@export var velocidade_ground: float
@export var velocidade_ar: float
@export var velocidade_sprint: float
var esta_correndo = false
var botao_ativo: bool
@onready var audio_pulo = $audio_pulo

@export var forca_pulo = 20
var timer_pulo: float
@export var timer_pulo_limite: float

var tem_o_item = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var vignette = $vignette
func _ready() -> void:
	vignette.play("open")

func _physics_process(delta: float) -> void:
	_movimentacao_no_chao(delta)
	_rollers(delta)
	_pulo(delta)
	_coyote_time()
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("sprint"):
		esta_correndo = !esta_correndo
	
	if self.velocity.x == 0:
		esta_correndo = false
	if esta_correndo == true:
		velocidade = velocidade_sprint
		animador.speed_scale = 2
	else:
		velocidade = velocidade_ground
		animador.speed_scale = 1
	move_and_slide()

@onready var particulas = $GPUParticles2D
@onready var animador = $AnimatedSprite2D
@onready var audio_run = $audio_run
func _movimentacao_no_chao(delta):
	if roller_mode == false:
		if Input.is_action_pressed("left"):
			self.velocity.x = -velocidade * delta
			if self.velocity.y == 0:
				animador.play("walk")
				particulas.emitting = true
			animador.flip_h = true
		elif Input.is_action_pressed("right"):
			self.velocity.x = velocidade * delta
			if self.velocity.y == 0:
				animador.play("walk")
				particulas.emitting = true
			animador.flip_h = false
		else:
			if roller_mode == false:
				self.velocity.x = 0
				if self.velocity.y == 0:
					animador.play("default")
					particulas.emitting = false
			else: 
				self.velocity.x = (velocidade_ground * 2) * delta
	else:
		animador.play("roller")
		
	if esta_correndo == true && is_on_floor():
		if !audio_run.is_playing():
			audio_run.play()
		particulas.amount = 15
	else:
		audio_run.stop()
		particulas.amount = 9
	
	if !is_on_floor():
		particulas.emitting = false
		velocidade = velocidade_ar
		print(animador.is_playing())
		if self.velocity.y > 0:
			animador.play("fall")
		elif self.velocity.y < 0:
			animador.play("jump")
	else:
		velocidade = velocidade_ground
		jump_count = 0

@export var jump_count_max: int
var jump_count: int
func _pulo(delta):
	if Input.is_action_pressed("jump") && jump_count < jump_count_max:
		if timer_pulo == 0:
			audio_pulo.play()
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

var roller_mode = false
func _rollers(delta):
	if roller_mode == true:
		self.velocity.x = (velocidade_ground+2000) * delta


func _close_anim():
	vignette.play("close")

func _on_vignette_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close":
		var end_trigger = get_tree().get_nodes_in_group("end")
		for node in end_trigger:
			node._next_level()


func _on_roller_stop_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var roller_part = $particulas_roller
		roller_mode = false
		roller_part.emitting = true
