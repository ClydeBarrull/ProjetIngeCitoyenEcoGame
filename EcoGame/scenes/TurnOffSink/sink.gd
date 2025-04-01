extends Node2D

class_name Sink

signal closedWater

var turningTime : float = 0.0 
var reduceStrength : int = 0

@onready var Sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var Flow : Waterflow = $Waterflow

func _ready():
	reduceStrength = randi_range(10,30);

func _on_handle_hitbox_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.is_pressed()) :
		Sprite.play("turning_handle")
		Flow.reduceWaterPercentage(reduceStrength)
		turningTime = Engine.get_frames_per_second() / 2

func _process(delta):
	turningTime = max(0, turningTime - 1)
	if (turningTime == 0) :
		Sprite.play("default")
		
func finished():
	closedWater.emit()
