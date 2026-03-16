extends Area3D

@export var cameraman : Node3D

@export var muda_rot = false
@export var muda_pos = false

@export var nova_pos = Vector3()
@export var nova_rot = Vector3()




func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if muda_rot:
			cameraman.activaterot(nova_rot)
		if muda_pos:
			cameraman.activatepos(nova_pos)
	pass # Replace with function body.
