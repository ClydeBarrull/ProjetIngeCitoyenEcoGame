extends Node2D

func _ready():
	# Itérer à travers chaque nœud `Character` dans la scène principale
	for i in range(get_child_count()):
		var character = get_child(i)
		
		# Calculer une position aléatoire sur l'axe horizontal
		var random_x = randf_range(100, 700)  # Utiliser randf_range pour un nombre flottant
		
		# Conserver la position verticale actuelle du personnage
		var vertical_position = character.position.y
		
		# Définir la nouvelle position du personnage (avec l'axe vertical conservé)
		character.position = Vector2(random_x, vertical_position)
