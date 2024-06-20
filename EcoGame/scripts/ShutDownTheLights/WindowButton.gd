extends Button

enum State {
	ON,
	OFF
}

var current_state = State.OFF

func _ready():
	# Initialisation aléatoire de l'état au démarrage
	if randf() > 0.5:
		set_state(State.ON)
	else:
		set_state(State.OFF)

func _on_Button_pressed():
	# Gérer le changement d'état lorsqu'on appuie sur le bouton
	if current_state == State.ON:
		set_state(State.OFF)
	else:
		set_state(State.ON)

func set_state(state):
	# Définir l'état et mettre à jour la couleur du bouton
	current_state = state
	update_button_color()

func update_button_color():
	# Mettre à jour la couleur du bouton en fonction de l'état
	if current_state == State.ON:
		self.modulate = Color(10, 10, 5)  # Jaune vif (valeur RGB ajustée)
	else:
		self.modulate = Color(0, 0, 0)  # Noir (valeur RGB)
