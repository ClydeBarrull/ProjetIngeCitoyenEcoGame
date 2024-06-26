extends MinigameGameplay

class_name GameManagerSDTL

var window_buttons = []
var characters = []
var visible_character_count = 0

var check_timer : Timer

# Liste des positions Y des différents étages
var floors = [0, -160, -310, -440, -600]

func _ready():
	# Récupérer tous les boutons à partir du chemin spécifié
	var buttons_parent = get_node("Building/Node2D")
	for button in buttons_parent.get_children():
		window_buttons.append(button)
		button.connect("toggled", Callable(self, "_on_button_toggled").bind(button))

	# Récupérer tous les personnages à partir du chemin spécifié
	var characters_parent = get_node("Node2D")
	for character in characters_parent.get_children():
		characters.append(character)
		character.connect("position_changed", Callable(self, "_on_character_moved").bind(character))

	# Mettre à jour la visibilité des personnages au démarrage
	update_characters_visibility()
	
	# Initialiser le timer
	InitializeTimerAndVeil()
	
	# Initialiser le timer pour vérifier le statut du jeu après 10 secondes
	check_timer = Timer.new()
	add_child(check_timer)
	check_timer.wait_time = 10
	check_timer.one_shot = true
	check_timer.timeout.connect(Callable(self, "_check_game_status"))
	check_timer.start()

func _process(delta):
	update_characters_visibility()

func _on_button_toggled(button, is_pressed):
	# Gérer l'événement de changement d'état du bouton
	print("Button toggled: ", button.name, " State: ", is_pressed)
	update_characters_visibility()

func _on_character_moved(character):
	# Mettre à jour la visibilité des personnages en fonction de la position
	print("Character moved: ", character.name, " Position: ", character.position)
	update_characters_visibility()

func get_floor_index(position_y):
	for i in range(floors.size()):
		if position_y == floors[i]:
			return i
	return -1

func update_characters_visibility():
	var new_visible_count = 0
	
	for character in characters:
		var character_sprite = character.get_node("Sprite2D/Sprite2D")
		var character_in_window = false
		var floor_index = get_floor_index(character.position.y)
		if floor_index == -1:
			continue # Ignore characters not on a known floor
		
		# Déterminer les boutons pour l'étage actuel du personnage
		var left_button = window_buttons[floor_index * 2]
		var right_button = window_buttons[floor_index * 2 + 1]

		# Vérifier la position y du personnage par rapport aux boutons
		if abs(character.position.y - floors[floor_index]) < 50:
			character_in_window = true
			if character.position.x <= -5:
				# Bouton de gauche
				print("Character ", character.name, " on left button ", left_button.name)
				if left_button.current_state == WindowButton.State.OFF:
					character_sprite.visible = true
				else:
					character_sprite.visible = false
			elif character.position.x >= 5:
				# Bouton de droite
				print("Character ", character.name, " on right button ", right_button.name)
				if right_button.current_state == WindowButton.State.OFF:
					character_sprite.visible = true
				else:
					character_sprite.visible = false
			else:
				# Entre les deux boutons, considéré comme valide par défaut
				print("Character ", character.name, " between buttons")
				character_sprite.visible = false

		if not character_in_window:
			character_sprite.visible = false
		
		if character_sprite.visible:
			new_visible_count += 1

func _check_game_status():
	if visible_character_count < 3:
		Wins()
	else:
		Fail()
