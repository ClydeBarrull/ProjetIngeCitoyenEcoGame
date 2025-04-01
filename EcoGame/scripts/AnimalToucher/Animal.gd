extends Node2D

class_name Animal

@export var touchable : bool = true

@onready var Sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var Hitbox : Area2D = $Area2D

func _ready():
	Hitbox.connect("input_event", input_happened);

func Play():
	print("played")
	show()
	await get_tree().create_timer(2.5).timeout
	waited()
	
func input_happened(viewport, event, shape_idx):
	if (event is InputEventMouseButton and visible and Sprite.animation == "default") :
		if (touchable) :
			Sprite.play("good")
			get_parent().behavioredWell()
		else :
			Sprite.play("bad")
			get_parent().behavioredBadly()

func waited():
	print("i waited")
	if (visible and Sprite.animation == "default"):
		if (touchable) :
			Sprite.play("bad")
			get_parent().behavioredBadly()
		else :
			Sprite.play("good")
			get_parent().behavioredWell()
