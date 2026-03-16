extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_ao_corpo_entrar)
	$"../AnimationPlayer".play("idle")
	
	pass # Replace with function body.

func _ao_corpo_entrar(body: Node3D):
	if body.is_in_group("player"):
		
		coletar()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func coletar():
	GameManager.addvida(1)
	$"../AnimationPlayer".play("coletado")
	await get_tree().create_timer(1.5).timeout
	queue_free()
	pass
