extends MinigameGameplay

class_name TrashGameplay

var SwipeableWasteList : WastesList
var isMoving : bool = false

func _ready():
	print("TrashGameplay ready")
	SwipeableWasteList = Utilities.getFirstChildOfType(self, WastesList)
	if SwipeableWasteList == null:
		push_error("SwipeableWasteList is not found")
		return
	SwipeableWasteList.Success.connect(CorrectRegistered)
	SwipeableWasteList.Failure.connect(FailureRegistered)  

	if SwipeableWasteList.SwipeableWasteList.size() < CorrectsThresholds + WrongsThreshold:
		push_error("Not enough items")

func _process(delta):
	if SwipeableWasteList.currentWaste != null and state == STATES.PLAYING and !isMoving:
		if Game.IsSwiped():
			isMoving = true
			SwipeableWasteList.currentWaste.GoUp()

func CorrectRegistered(howMany:int=1):
	CorrectsThresholds -= howMany
	if CorrectsThresholds <= 0:
		Wins()
	else:
		isMoving = false

func FailureRegistered(howMany:int=1):
	WrongsThreshold -= howMany 
	if WrongsThreshold <= 0:
		Fail()
	else:
		isMoving = false
