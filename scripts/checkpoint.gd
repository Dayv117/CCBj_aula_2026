extends Node3D




func _on_area_3d_body_entered(body: Node3D) -> void:
	GameManager2.Gamemanagerinscene.saveposplayer = body.global_position
	Saveload.saveloadscene.save_game()
	$CanvasLayer/AnimationPlayer.play("new_animation")
	pass # Replace with function body.
