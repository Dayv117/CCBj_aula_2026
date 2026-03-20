extends Node3D
var vida: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if vida <= 0:
		queue_free()
		
	print(vida)
	pass





func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.name == "Areaataque":
		print("inimigo tomou")
		vida -= 1
		
	pass # Replace with function body.


func _on_ativar_ataque_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$AnimationPlayer.play("ataque")
		await get_tree().create_timer(3).timeout
		$AnimationPlayer.play("RESET")
	
	pass # Replace with function body.


func _on_areaataque_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		GameManager.levardano(1)
	pass # Replace with function body.
