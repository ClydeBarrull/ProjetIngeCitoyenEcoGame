extends Node

class_name WastesList

var currentWaste : Waste
var SwipeableWasteList : Array
var currentIndex : int = 0

signal Success
signal Failure


func _ready():
	SwipeableWasteList = Utilities.GetListoFChildOfType(self,Waste)
	var currentLayer = SwipeableWasteList.size() + 1
	for child in SwipeableWasteList:
		var childSprite = child as Sprite2D
		currentLayer -= 1
		childSprite.z_index = currentLayer
	NextWaste()

func NextWaste():
	if currentWaste != null :
		currentWaste.Correct.disconnect(RegisterSuccess)
		currentWaste.Wrong.disconnect(RegisterFailure)
		currentWaste.queue_free()
	if currentIndex < SwipeableWasteList.size():
		currentWaste = SwipeableWasteList[currentIndex] as Waste
		currentWaste.visible = true
		currentWaste.Correct.connect(RegisterSuccess)
		currentWaste.Wrong.connect(RegisterFailure)
		currentIndex += 1
	else:
		currentWaste = null
		print("No more wastes")
		



func _sort_wastes_by_z_index(a, b):
	return b.z_index - a.z_index

func RegisterSuccess():
	Success.emit()
	NextWaste()

func RegisterFailure():
	Failure.emit()
	NextWaste()
