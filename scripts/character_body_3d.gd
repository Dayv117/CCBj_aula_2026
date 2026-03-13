extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10
@onready var piv: Node3D = $piv
@onready var anim: AnimationPlayer = $piv/buddybuddy/AnimationPlayer
var atacando: bool = false
var naoataca: bool = false
var num_rotacao = deg_to_rad(0)
@export var turn_vel = 7.5
func _ready() -> void:
	$piv/Areaataque/CollisionShape3D2.disabled = true
func _process(delta: float) -> void:
	animation(delta)
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		naoataca = true
		velocity += get_gravity() * delta
	if is_on_floor():
		naoataca = false
	if naoataca == false:
		
		if Input.is_action_just_pressed("ataque"):
			atacando = true
			anim.play("Attack")
			await get_tree().create_timer(2).timeout
			
		
			atacando = false
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		anim.play("Jump")
		velocity.y = JUMP_VELOCITY

	if !atacando:
		
		var input_dir := Input.get_vector("esquerda", "direita", "frente", "atras")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
	
func animation(delta):
	if is_on_floor():
		var andando = false
		
		if !atacando:
			
			if Input.is_action_pressed("frente"):
				andando = true
				anim.play("Walk")
				num_rotacao = deg_to_rad(0)
				if Input.is_action_pressed("esquerda"):
					num_rotacao = deg_to_rad(45)
				elif Input.is_action_pressed("direita"):
					num_rotacao = deg_to_rad(-45)
				rotacionar(delta)
			elif Input.is_action_pressed("atras"):
				andando = true
				anim.play("Walk")
				num_rotacao = deg_to_rad(180)
				if Input.is_action_pressed("esquerda"):
					num_rotacao = deg_to_rad(135)
				elif Input.is_action_pressed("direita"):
					num_rotacao = deg_to_rad(-135)
				rotacionar(delta)
			elif Input.is_action_pressed("esquerda"):
				andando = true
				anim.play("Walk")
				num_rotacao = deg_to_rad(90)
				rotacionar(delta)
			elif Input.is_action_pressed("direita"):
				andando = true
				anim.play("Walk")
				num_rotacao = deg_to_rad(-90)
				rotacionar(delta)
			else:
				andando = false
				anim.play("Idle")
func rotacionar(delta):
	piv.rotation.y = lerp_angle(piv.rotation.y, num_rotacao, turn_vel * delta)
func save():
	print(position)
	var save_dict = {
		"filename" : get_scene_file_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"pos_z" : position.z,
		"current_healt" : GameManager.vida_atual,
	}	
	return save_dict
func loaddata(node_data)->void:
	position.x = node_data["pos_x"]
	position.y = node_data["pos_y"]
	position.z = node_data["pos_z"]
	#print(position)
	#GameManager.vida_atual = node_data["current_health"]
