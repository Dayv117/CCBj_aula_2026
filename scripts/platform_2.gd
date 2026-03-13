extends MeshInstance3D

@onready var area_deteccao: Area3D = $Area3D
var jogador_na_plataforma: Node3D = null
var ultima_posicao: Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ultima_posicao = global_position
	area_deteccao.body_entered.connect(_on_area_3d_body_entered)
	area_deteccao.body_exited.connect(_on_area_3d_body_exited)
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var movimento = global_position - ultima_posicao
	
	if jogador_na_plataforma and movimento != Vector3.ZERO:
		jogador_na_plataforma.global_position += movimento
	ultima_posicao = global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		jogador_na_plataforma = body
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == jogador_na_plataforma:
		jogador_na_plataforma = null
	pass # Replace with function body.
