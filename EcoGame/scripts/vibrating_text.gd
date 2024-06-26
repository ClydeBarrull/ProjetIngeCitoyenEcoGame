extends Node2D

class_name VibratingText

@export var TextColor : Color = Color(186,186,186)
@export var Text : String = "Texte vibrant"
@export var Shake : int = 20
@export var Speed : int = 5

@onready var label : Label = $Text

var Shaking : bool = true
var shakeRectangle : Vector2i
var initialPos : Vector2i

var howManyFramesBeforeMovement : int = 0

func _ready():
	label.text = Text
	label.label_settings.font_color = TextColor
	shakeRectangle = Vector2i(label.get_rect().size.x/Shake, label.get_rect().size.y/Shake)
	initialPos = Vector2(global_position.x - label.get_rect().size.x,global_position.y)

func _process(_delta):
	if (Shaking):
		global_position = Vector2i(initialPos.x + (randi_range(-shakeRectangle.y,shakeRectangle.y)),
		initialPos.y + (randi_range(-shakeRectangle.y,shakeRectangle.y)))

func stopsShaking():
	Shaking = false
	z_index -= z_index
	
func resumeShaking():
	Shaking = true
	
func showGoodMessage():
	label.text = "Vrai ! Correct !"
	label.label_settings.font_color = Color(0,255,0)
	
func showBadMessage():
	label.text = "Faux ! Wrong !"
	label.label_settings.font_color = Color(255,0,0)
