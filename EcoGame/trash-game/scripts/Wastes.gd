extends Sprite2D

class_name Waste

@export var speed : int = 1000

var moving : bool = false
var destination : Vector2
var CurrentArea : Waste_Area

var SwipeLength : int

signal Correct
signal Wrong

func _ready():
	SwipeLength = get_viewport().get_visible_rect().size.x
	
	# Assign CurrentArea by finding the child node
	CurrentArea = get_node("Waste") as Waste_Area
	
	if CurrentArea != null:
		CurrentArea.Correct.connect(_on_success)
		CurrentArea.Wrong.connect(_on_failure)
	else:
		print("CurrentArea is not assigned!")

func _process(delta):
	if moving:
		if self.position.distance_to(destination) <= 10:
			moving = false
		else:
			var move_vector = destination - self.position
			self.position += move_vector.normalized() * speed * delta

func _on_success():
	print("yippee")
	Correct.emit()

func _on_failure():
	print("bummer :/")
	Wrong.emit()

func GoUp():
	destination = Vector2(position.x, position.y - SwipeLength)
	moving = true
