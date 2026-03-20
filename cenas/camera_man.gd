extends Node3D

@export var player : CharacterBody3D
@export var vel = 4.5
@onready var spring: SpringArm3D = $SpringArm3D
@onready var piv: Node3D = $SpringArm3D/Offseter/Piv
@export var encara = false


func _process(delta: float) -> void:
	if player:
		self.global_position = global_position.move_toward(player.global_position, vel * delta)
		if encara:
			piv.look_at(player.global_transform.origin, Vector3.UP)

func activeterot(rotacao):
	var rot_tween = create_tween()
	rot_tween.tween_property(spring, 'rotation_degrees',rotacao,0.5)
	player.rotation_degrees.y = rotation_degrees.move_toward(rotacao, vel * 60).y

func activatepos(posicao):
	var pos_tween = create_tween()
	pos_tween.tween_property(spring, 'position', posicao,0.5)
