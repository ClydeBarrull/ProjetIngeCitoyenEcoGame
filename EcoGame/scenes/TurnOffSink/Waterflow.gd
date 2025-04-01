extends Node2D

class_name Waterflow

@onready var Sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var droughtThreshold : float = 0.03

func _ready():
	Sprite.play("default")

func reduceWaterPercentage(percentage: float) :
	Sprite.apply_scale(Vector2(1-(percentage/100),1))
	if (Sprite.scale.x < droughtThreshold) :
		Sprite.hide()
		(get_parent() as Sink).finished()
