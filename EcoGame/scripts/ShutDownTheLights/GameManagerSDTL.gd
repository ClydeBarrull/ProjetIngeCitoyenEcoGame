extends Node

class_name GameManager

var window_buttons = []
var characters = []

func _ready():
	# Récupérer tous les boutons et les personnages dans la scène
	window_buttons = get_tree().get_nodes_in_group("WindowButtons")
	characters = get_tree().get_nodes_in_group("Characters")

	# Initialiser les personnages et les boutons
	for button in window_buttons:
		button.connect("pressed", Callable(self, "_on_button_pressed").bind(button))

	for character in characters:
		character.connect("position_changed", Callable(self, "_on_character_moved").bind(character))

	update_characters_visibility()

func _on_button_pressed(button):
	# Gérer l'événement de bouton pressé
	if button.current_state == WindowButton.State.ON:
		button.set_state(WindowButton.State.OFF)
	else:
		button.set_state(WindowButton.State.ON)

	update_characters_visibility()

func _on_character_moved(character):
	# Mettre à jour la visibilité des personnages en fonction de la position
	update_characters_visibility()

func update_characters_visibility():
	# Mettre à jour la visibilité des personnages en fonction des états des boutons
	for character in characters:
		var character_sprite = character.get_node("Sprite2D")
		var character_in_window = false

		for button in window_buttons:
			if abs(character.position.y - button.position.y) < 10:
				character_in_window = true
				character_sprite.visible = (button.current_state == WindowButton.State.ON)

		if not character_in_window:
			character_sprite.visible = false
