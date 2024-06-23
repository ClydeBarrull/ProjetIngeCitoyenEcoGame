extends Node

class_name SwipeableItemList

var SwipeableItemsList : Array
var vibratingText : VibratingText

var currentItem : SwipeableItem
var currentIndex : int = 0

signal CorrectSwipe
signal WrongSwipe

func _ready():
	vibratingText = Utilities.getFirstChildOfType(self,VibratingText)
	SwipeableItemsList = Utilities.GetListoFChildOfType(self,SwipeableItem)
	SwipeableItemsList.shuffle()
	var currentLayer = SwipeableItemsList.size() + 2
	for children in SwipeableItemsList:
		var childrenAsSprite = (children as Sprite2D)
		currentLayer -= 1
		childrenAsSprite.z_index = currentLayer
	
	InitializeNext()

func InitializeNext():
	if (currentItem != null) :
		currentItem.CorrectSwipe.disconnect(RegisteredCorrectSwipe)
		currentItem.WrongSwipe.disconnect(RegisteredWrongSwipe)
		currentItem.queue_free()
	
	currentItem = (SwipeableItemsList[currentIndex] as SwipeableItem)
	currentItem.visible = true
	currentItem.CorrectSwipe.connect(RegisteredCorrectSwipe)
	currentItem.WrongSwipe.connect(RegisteredWrongSwipe)
	
	currentIndex += 1
	
func RegisteredCorrectSwipe():
	vibratingText.showGoodMessage()
	InitializeNext()
	CorrectSwipe.emit()
	
func RegisteredWrongSwipe():
	vibratingText.showBadMessage()
	InitializeNext()
	WrongSwipe.emit()
