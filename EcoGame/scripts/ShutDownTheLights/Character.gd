extends Node2D

class_name Character

var speed = 100
var direction = Vector2.RIGHT
var left_limit = 200
var right_limit = 500
var change_direction_interval_min = 1.0  # Intervalle minimal de temps en secondes pour le changement de direction
var change_direction_interval_max = 3.0  # Intervalle maximal de temps en secondes pour le changement de direction
var time_since_last_direction_change = 0.0
var next_direction_change_time = 0.0

var anim_player
var collision_shape

func _ready():
	# Rendre le Sprite2D enfant invisible par défaut
	get_node("Sprite2D/Sprite2D").visible = false
	
	# Initialiser la direction de manière aléatoire
	if randf() > 0.5:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
	
	# Initialiser le prochain changement de direction aléatoire
	set_next_direction_change()
	
	anim_player = $AnimationPlayer
	collision_shape = $StaticBody2D/CollisionShape2D

	# Connecter le signal de collision du StaticBody2D
	var area = collision_shape.get_parent().get_parent()  # Obtenir l'Area2D parent du CollisionShape2D
	if area:
		area.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	anim_player.play("CharacterMovement")
	
	time_since_last_direction_change += delta
	
	# Vérifier s'il est temps de changer de direction
	if time_since_last_direction_change >= next_direction_change_time:
		change_direction()
		set_next_direction_change()
	
	# Déplacer le personnage
	var new_position = position + direction * speed * delta
	if new_position.x < left_limit:
		new_position.x = left_limit
		change_direction()
		set_next_direction_change()
	elif new_position.x > right_limit:
		new_position.x = right_limit
		change_direction()
		set_next_direction_change()
	position = new_position

func change_direction():
	# Changer de direction aléatoirement
	direction = direction * -1

func set_next_direction_change():
	# Définir le temps avant le prochain changement de direction aléatoire
	next_direction_change_time = randf_range(change_direction_interval_min, change_direction_interval_max)
	time_since_last_direction_change = 0.0

func show_character_sprite(visible):
	print("Showing character sprite:", visible)
	get_node("Sprite2D").visible = visible

func _on_body_entered(body):
	# Masquer le Sprite2D lorsque le personnage entre en contact avec un autre collider
	print("Character entered a collider")
	show_character_sprite(false)
