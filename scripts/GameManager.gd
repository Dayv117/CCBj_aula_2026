extends Node
class_name GameManager2
static var Gamemanagerinscene
var vida_atual: int = 3
var vida_maxima: int = 3
var saveposplayer: Vector3 = Vector3.ZERO
var playernode: Node3D
var pontos: int = 0
var jogo_iniciado: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemanagerinscene = self
	if jogo_iniciado == true:
		vida_atual = vida_maxima
		
		playernode = get_tree().get_first_node_in_group("player")
		saveposplayer = playernode.global_position
	
	#vida_atual = vida_maxima
	#Gamemanagerinscene = self
	#playernode = get_tree().get_first_node_in_group("player")
	#saveposplayer = playernode.global_position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func morrer():
	get_tree().change_scene_to_file("res://cenas/teladerrota.tscn")
	
func addvida(quantidade: int):
	
	if vida_atual <= vida_maxima:
		vida_atual += 1
	
	pass

func addponto(quantidade: int):
	pontos += 1
	pass

func levardano(quantidade: int):
	vida_atual -= 1
	if vida_atual <= 0:
		morrer()
		pass
	pass
