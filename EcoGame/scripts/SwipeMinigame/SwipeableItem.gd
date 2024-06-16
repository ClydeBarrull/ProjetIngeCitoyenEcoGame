extends Sprite2D

class_name SwipeableItem

@export var isCorrect : bool
@export var speed : int = 3

var SwipeLength : int

var SwipedRight : bool

var Moving : bool = false

var destination: Vector2

signal CorrectSwipe
signal WrongSwipe

func _ready():
	SwipeLength = (get_viewport_rect().size.x)

func _process(delta):
	if (Moving) :
		if (position.distance_to(destination) <= 50) :
			CheckIfSwipeIsRight()
		else :
			position.x += position.direction_to(destination).x * SwipeLength * delta * speed

func GoRight():
	SwipedRight = true
	destination = Vector2(position.x + SwipeLength, position.y)
	Moving = true
	
func GoLeft():
	SwipedRight = false
	destination = Vector2(position.x - SwipeLength, position.y)
	Moving = true
	
func CheckIfSwipeIsRight():
	Moving = false
	if ((isCorrect and SwipedRight) or (!isCorrect and !SwipedRight)) :
		CorrectSwipe.emit()
	else :
		WrongSwipe.emit()
	
