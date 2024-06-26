extends MinigameGameplay

class_name TrashGameplay

var SwipeableWasteList : WastesList
var isMoving : bool = false
@export var numWaste : int = 4

func _ready():
	print("TrashGameplay ready")
	SwipeableWasteList = Utilities.getFirstChildOfType(self, WastesList)
	if SwipeableWasteList == null:
		push_error("SwipeableWasteList is not found")
		return
	SwipeableWasteList.Success.connect(CorrectRegistered)
	SwipeableWasteList.Failure.connect(FailureRegistered)  

	if SwipeableWasteList.SwipeableWasteList.size() < numWaste + WrongsThreshold:
		push_error("Not enough items")

func _process(delta):
	if SwipeableWasteList.currentWaste != null and state == STATES.PLAYING and not isMoving:
		var swiped = Game.IsSwiped(Vector2i(0, 1), 1)  # Call with the speed parameter set to 1
		if swiped:
			isMoving = true
			SwipeableWasteList.currentWaste.GoUp()


func CorrectRegistered(howMany:int=1):
	numWaste -= howMany
	print("remaining : ", numWaste)
	if numWaste <= 0:
		Wins()
	else:
		isMoving = false

func FailureRegistered(howMany:int=1):
	WrongsThreshold -= howMany 
	if WrongsThreshold <= 0:
		Fail()
	else:
		isMoving = false
