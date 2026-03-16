extends CharacterBody3D

@export var projetil: PackedScene
@export var ponto_de_tiro: Node3D
@export var tempo_entre_tiros: float = 3


var jogador: Node3D = null
var pode_atirar: bool = true
var vida: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var area = $reconhecimento
	area.body_entered.connect(_ao_jogador_entrar)
	area.body_exited.connect(_ao_jogador_sair)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not jogador:
		$AnimationPlayer.play("idle")
		$MeshInstance3D2.hide()
		$MeshInstance3D.hide()
	if jogador and pode_atirar:
		$MeshInstance3D2.show()
		$MeshInstance3D.show()
		var pos_alvo = Vector3(jogador.global_position.x, global_position.y, jogador.global_position.z)
		look_at(pos_alvo, Vector3.UP)
		rotate_y(deg_to_rad(180))
		atirar()
		pode_atirar = false
		await get_tree().create_timer(tempo_entre_tiros).timeout
		pode_atirar = true
	if vida <= 0:
		$AnimationPlayer.play("death")
	pass
	
func _ao_jogador_entrar(body: Node3D):
	if body.is_in_group("player"):
		jogador = body
 
func _ao_jogador_sair(body: Node3D):
	if body == jogador:
		jogador = null

func atirar():
	$AnimationPlayer.play("attack")
	if not projetil or not ponto_de_tiro or not jogador:
		return
	var tiro = projetil.instantiate()
	get_tree().current_scene.add_child(tiro)
	
	tiro.global_position = ponto_de_tiro.global_position
	
	var direcao = (jogador.global_position - tiro.global_position).normalized()
	tiro.velocity = direcao * 20


func _on_levardano_area_entered(area: Area3D) -> void:
	if area.name == "Areaataque":
		print("inimigo tomou")
		vida -= 1
	pass # Replace with function body.
