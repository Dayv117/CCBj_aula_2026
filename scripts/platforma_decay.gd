extends MeshInstance3D

@export var velocidade_vibracao: float = 15.0
@export var intensidade_vibracao: float = 5.0
@export var tempo_para_desaparecer: float = 2.0
@export var tempo_para_reaparecer: float = 3.0
@export var escala_inicial: float = 1.0
@export var eixo_vibracao: Vector3 = Vector3.RIGHT

@export var platforma_4_decay: MeshInstance3D 
@export var collision_shape_3d: CollisionShape3D 
@export var area_3d: Area3D 

var timer_reaparecer: Timer

var jogador_no_trigger: bool = false
var plataforma_ativa: bool = true
var vibracao_atua: float = 0.0
var tempo_vibracao: float = 0.0
var posicao_original: Vector3
var escala_original: Vector3
##
func _ready() -> void:
	posicao_original = position
	if platforma_4_decay:
		escala_original = platforma_4_decay.scale 
	else:
		escala_original = Vector3(escala_inicial, escala_inicial, escala_inicial)
	if platforma_4_decay:
		platforma_4_decay.scale = escala_original
	if area_3d:
		area_3d.body_entered.connect(_on_area_entered)
		area_3d.body_exited.connect(_on_area_exited)

func _process(delta: float) -> void:
	if jogador_no_trigger and plataforma_ativa:
		vibrar_plataforma(delta)
		if tempo_vibracao >= 1.0:
			diminuir_escala(delta)
			await get_tree().create_timer(3).timeout
			reaparecer_plataforma()
	if not plataforma_ativa:
		if platforma_4_decay:
			platforma_4_decay.scale = Vector3.ZERO


func reaparecer_plataforma():
	plataforma_ativa = true
	jogador_no_trigger = false
	tempo_vibracao = 0.0
	
	position = posicao_original
	scale = escala_original
	
	visible = true
	collision_shape_3d.disabled = false

func _on_timer_reaparecer_timeout():
	reaparecer_plataforma()

func vibrar_plataforma(delta):
	tempo_vibracao += delta
	
	if tempo_vibracao < 1.0:
		vibracao_atua = sin(tempo_vibracao * velocidade_vibracao * 10) * intensidade_vibracao
		
		position = posicao_original + (eixo_vibracao * vibracao_atua)
		
		if platforma_4_decay:
			var escala_vibracao = 1.0 + sin(tempo_vibracao * 30) * 0.05
			platforma_4_decay.scale = escala_original * escala_vibracao
	
func diminuir_escala(delta):
	if platforma_4_decay:
		var progresso = (tempo_vibracao - 1.0) / tempo_para_desaparecer
		progresso = clamp(progresso,0.0,1.0)
		var escala_atual = escala_original * (1.0 - progresso)
		platforma_4_decay.scale = escala_atual
		if escala_atual.length() <= 0.01:
			plataforma_ativa = false
			collision_shape_3d.disabled = true
			platforma_4_decay.visible = false
			hide()


func _on_area_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		jogador_no_trigger = true
		emit_signal("naplataforma")
		print("jogadour entrou na area")
	pass # Replace with function body.


func _on_area_exited(body: Node3D) -> void:
	if body.is_in_group("jogador:"):
		if plataforma_ativa and tempo_vibracao < 1.0:
			jogador_no_trigger = false
			tempo_vibracao = 0.0
			position = posicao_original
			if platforma_4_decay:
				platforma_4_decay.scale = escala_original
			print("jogador saiu da area")
	pass # Replace with function body.
