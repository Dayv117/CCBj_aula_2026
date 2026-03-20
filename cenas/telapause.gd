extends Control
var pausado: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	$".".hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_game()
	pass
func pause_game():
	pausado = true
	$".".show()
	get_tree().paused = true
	

func _on_button_button_down() -> void:
	despausar()
	pass # Replace with function body.
func despausar():
	if pausado:
		pausado = false
		get_tree().paused = false
		$".".hide()

	

func _on_button_2_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/menuinicial.tscn")
	pass # Replace with function body.
