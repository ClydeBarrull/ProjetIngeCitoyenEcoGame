extends MinigameGameplay

class_name SwipeGameplay

var SwipeableItemsList : SwipeableItemList

var failGauge : FailGauge

var isMoving : bool = false

func _ready():
	failGauge = Utilities.getFirstChildOfType(self,FailGauge)
	SwipeableItemsList = Utilities.getFirstChildOfType(self,SwipeableItemList)
	SwipeableItemsList.CorrectSwipe.connect(CorrectRegistered)
	SwipeableItemsList.WrongSwipe.connect(WrongRegistered)
	
	if (SwipeableItemsList.SwipeableItemsList.size() < CorrectsThresholds + WrongsThreshold):
		push_error("Not enough items in Swipe Minigame for number of tries !")
		
func _process(delta):
	if (SwipeableItemsList.currentItem != null and state == STATES.PLAYING and !isMoving) :
		if (Game.IsSwiped(Vector2i(1,0))) :
			isMoving = true
			SwipeableItemsList.currentItem.GoRight()
		if (Game.IsSwiped(Vector2i(-1,0))):
			isMoving = true
			SwipeableItemsList.currentItem.GoLeft()

func WrongRegistered(howMany:int=1):
	failGauge.failOne()
	WrongsThreshold -= howMany
	if (WrongsThreshold <= 0) :
		Fail()
	else:
		isMoving = false

func CorrectRegistered(howMany:int=1):
	CorrectsThresholds -= howMany
	if (CorrectsThresholds <= 0):
		Wins()
	else:
		isMoving = false
