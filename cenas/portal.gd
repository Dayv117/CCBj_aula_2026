extends Area3D
@export var camera: Node3D
@export var camera2: Node3D
var camera_rotacion: Vector3 = Vector3(0,90,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../teladecarregamento".hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$"../../teladecarregamento".show()
		camera.current = false
		camera2.current = true
		camera.rotation_degrees = camera_rotacion
		body.global_position = $Marker3D1.position
		await get_tree().create_timer(4).timeout
		$"../../teladecarregamento".hide()
	pass # Replace with function body.
