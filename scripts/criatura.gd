extends Node3D

enum estado  {ANDANDO,ATAQUE,MORTO}
var state = estado.ANDANDO
@onready var anim: AnimationPlayer = $Path3D/PathFollow3D/SpringArm3D/pivot/lobaoo/AnimationPlayer
@onready var animpath: AnimationPlayer = $AnimationPlayer
@onready var follow: PathFollow3D = $Path3D/PathFollow3D
@onready var lobao: Node3D = $Path3D/PathFollow3D/SpringArm3D/pivot/lobaoo
var vida = 1
var alvo
var speed = 7
func _process(delta: float) -> void:
	if vida <= 0:
		state = estado.MORTO
		print("morreu")
	
	match  state:
		estado.ANDANDO:
			anim.play("Walk")
			anim.speed_scale = 1
			follow.progress += speed * delta
			lobao.rotation_degrees = Vector3(-88.4,-23.3,23)
			pass
		estado.ATAQUE:
			lobao.look_at(alvo.global_transform.origin, Vector3.UP)
			anim.speed_scale = 0.4
			anim.play("Attack")
			
			pass
		estado.MORTO:
			anim.play("morte")
			await get_tree().create_timer(2).timeout
			queue_free()
			pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and vida >= 1:
		state = estado.ATAQUE
		alvo = body
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		state = estado.ANDANDO
	pass # Replace with function body.

func attack():
	GameManager.levardano(1)
	#print("tomou ",1)


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.name == "Areaataque":
		print("inimigo tomou")
		vida -= 1
	pass # Replace with function body.
