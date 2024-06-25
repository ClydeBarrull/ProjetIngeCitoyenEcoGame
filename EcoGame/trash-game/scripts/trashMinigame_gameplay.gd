extends MinigameGameplay

class_name TrashGameplay

var SwipeableWasteList : WastesList
var isMoving : bool = false
@export var numWaste : int = 3

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
	if SwipeableWasteList.currentWaste != null and state == STATES.PLAYING and !isMoving:
		if Game.IsSwiped():
			isMoving = true
			SwipeableWasteList.currentWaste.GoUp()

func CorrectRegistered(howMany:int=1):
	print("gameplay level insane")
	numWaste -= howMany
	print("remaining : ", numWaste)
	if numWaste <= 0:
		print("its over ???")
		Wins()
	else:
		isMoving = false

func FailureRegistered(howMany:int=1):
	WrongsThreshold -= howMany 
	if WrongsThreshold <= 0:
		Fail()
	else:
		isMoving = false
