extends RigidBody3D

signal coletado

func _ready() -> void:
	var area3Dhere = $Area3D
	area3Dhere.area_entered.connect(Coletar)

func Coletar(enterNode: Area3D) -> void:
	
	#if enterNode.owner.is_in_group("Player"):
		##return
		#pass
	coletado.emit()
	queue_free()
	print("pegou")
	GameManager.addponto(1)
	$coleta.play()



func _on_coletado() -> void:
	pass # Replace with function body.
