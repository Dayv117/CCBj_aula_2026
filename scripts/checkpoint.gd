extends Node3D




func _on_area_3d_body_entered(body: Node3D) -> void:
	GameManager.Gamemanagerinscene.saveposplayer = body.global_position
	Saveload.saveloadscene.save_game()
	print("chamou")
	pass # Replace with function body.
