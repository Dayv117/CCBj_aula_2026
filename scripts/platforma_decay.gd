extends MeshInstance3D



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$AnimationPlayer.play("caindo")
		await get_tree().create_timer(5).timeout
		$AnimationPlayer.play("sumindo")
		$StaticBody3D/CollisionShape3D.disabled = true
		await get_tree().create_timer(5).timeout
		$AnimationPlayer.play("aparecendo")
		$StaticBody3D/CollisionShape3D.disabled = false
	pass # Replace with f$AnimationPlayerunction body.
