extends Node

class_name GameManagerSDTL

var window_buttons = []
var characters = []
var points = 0
var success = false

func _ready():
	# Récupérer tous les boutons et les personnages dans la scène
	window_buttons = get_tree().get_nodes_in_group("WindowButtons")
	characters = get_tree().get_nodes_in_group("Characters")

	# Initialiser les personnages et les boutons
	for button in window_buttons:
		button.connect("pressed", Callable(self, "_on_button_pressed").bind(button))

	for character in characters:
		# Connecter un signal pour mettre à jour la visibilité du sprite du personnage
		connect_character_signals(character)

	update_characters_visibility()
	update_points_and_success()

func _on_button_pressed(button):
	# Gérer l'événement de bouton pressé
	if button.current_state == WindowButton.State.ON:
		var characters_on_button = get_characters_on_button(button)
		if characters_on_button == 0:
			points += 1
	else:
		for character in characters:
			var character_position = character.position
			if abs(character_position.y - button.position.y) < 10:
				# Appeler la fonction du personnage pour afficher le sprite
				character.show_character_sprite(true)
				points += 1

	update_points_and_success()

func _on_character_moved(character):
	# Mettre à jour la visibilité des personnages en fonction de la position
	update_characters_visibility()
	update_points_and_success()

func update_characters_visibility():
	# Mettre à jour la visibilité des personnages en fonction des états des boutons
	for character in characters:
		var character_sprite = character.get_node("Sprite2D")
		var character_in_window = false

		for button in window_buttons:
			if abs(character.position.y - button.position.y) < 10:
				character_in_window = true
				if button.current_state == WindowButton.State.OFF:
					character_sprite.visible = true
				else:
					character_sprite.visible = false

		if not character_in_window:
			character_sprite.visible = false

func update_points_and_success():
	# Mettre à jour le booléen de succès en fonction du nombre de points
	success = points < 1

func connect_character_signals(character):
	# Connecter un signal pour détecter le mouvement du personnage
	character.connect("position_changed", Callable(self, "_on_character_moved").bind(character))

func get_characters_on_button(button):
	var count = 0
	for character in characters:
		var character_position = character.position
		if abs(character_position.y - button.position.y) < 10:
			count += 1
	return count
