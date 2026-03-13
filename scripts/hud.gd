extends Control

var textura_dano = 20
@onready var barra_vida: TextureRect = $HBoxContainer/TextureRect
@onready var pontushud: Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.vida_atual == 1:
		barra_vida.custom_minimum_size.x =textura_dano
		pass
	if GameManager.vida_atual == 2:
		barra_vida.custom_minimum_size.x =textura_dano * 2
	if GameManager.vida_atual == 3:
		barra_vida.custom_minimum_size.x =textura_dano * 3
	if GameManager.vida_atual <= 0:
		barra_vida.custom_minimum_size.x = 0
	$Label.text = str("pontos: ",GameManager.pontos)
	pass
