extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/CanvasLayer/AnimationPlayer.play("fade_out")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("ai")
	pass


func _on_button_pressed() -> void:
	print("aiaiai")
	$Control/CanvasLayer/AnimationPlayer.play("fade")
	get_tree().change_scene_to_file("res://cenas/mundo.tscn")
	GameManager.jogo_iniciado = true
	pass # Replace with function body.
