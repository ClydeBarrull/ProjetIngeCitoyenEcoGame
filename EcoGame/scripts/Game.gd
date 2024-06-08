extends Node2D

class_name Game

@export var length : int = 50

static var SwipeInfo : Array = []

var swipeFrames : int = 0

var startPos : Vector2
var curPos : Vector2
var swiping : bool = false

func _process(delta):
	CheckSwipe()
		
func CheckSwipe():
	if Input.is_action_just_pressed("Tap"):
		if !swiping:
			swiping = true
			startPos = get_global_mouse_position()
	
	if Input.is_action_pressed("Tap"):
		if swiping:
			swipeFrames += 1
			curPos = get_global_mouse_position()
			if startPos.distance_to(curPos) >= length:
				
				var direction : Vector2i
				direction.x = 1 if (startPos.x < curPos.x) else -1
				direction.y = 1 if (startPos.y < curPos.y) else -1
				
				SwipeInfo = [(length / swipeFrames),direction]
				swiping = false
				swipeFrames = 0
				
	else :
		swiping = false
		SwipeInfo = []
		
static func IsSwiped(direction:Vector2i = Vector2i(0,0), speed:int = 5):
	if (SwipeInfo == []) : return false
	if (speed >= SwipeInfo[0]) : return false
	
	var thresholdX : Array = [sign((SwipeInfo[1] as Vector2i).x),0]
	var thresholdY : Array = [sign((SwipeInfo[1] as Vector2i).y) * -1,0]
	
	if ((direction.x in thresholdX) and (direction.y in thresholdY)) :
		SwipeInfo = []
		return true
	else :
		return false

