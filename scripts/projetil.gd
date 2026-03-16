extends CharacterBody3D

@export var dano:  int = 1
@export var velocidade: float = 20

func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	velocity = velocity.normalized() * velocidade
	move_and_slide()
	
	for i in get_slide_collision_count():
		var colisao = get_slide_collision(i)
		var alvo = colisao.get_collider()
		
		if alvo.is_in_group("player"):
			GameManager.levardano(1)
			queue_free()
		elif not alvo.is_in_group("inimigo"):
			queue_free() 


#func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body.is_in_group("jogador")
		#print("levou dano")
	#pass # Replace with function body.
