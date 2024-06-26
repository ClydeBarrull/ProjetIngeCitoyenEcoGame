extends Node2D

class_name BombTimer

signal timeout

@onready var timer : BombTimerComponent = $Timer
@onready var timeDisplay : Label = $TimeLeftCounter

var stateImages : Array

var timeLeft : float
var periodLength : int
var howManyStatesTillEnd : int

var dangerMode : bool = false

func _ready():
	stateImages = Utilities.GetListoFChildOfType(self,Sprite2D)
	howManyStatesTillEnd = stateImages.size() - 1
	timer.setParent(self)
	
func setTime(time:float):
	periodLength = time / stateImages.size()
	timeLeft = time
	timer.wait_time = time
	timer.start()
	
func updateTime(time:float):
	timeLeft = time
	
func _process(delta):
	if (timeLeft > 0):
		if (timeLeft < (periodLength * howManyStatesTillEnd)):
			howManyStatesTillEnd -= 1
			if (howManyStatesTillEnd >= 0):
				nextImage()
			if (howManyStatesTillEnd == 0 and !dangerMode):
				dangerMode = true
				timeDisplay.label_settings.font_color = Color(255,0,0)
				timeDisplay.label_settings.font_size -= (timeDisplay.label_settings.font_size / 2)
	
	if (!dangerMode):
		timeDisplay.text = str(timeLeft).pad_decimals(0)
	else:
		timeDisplay.text = str(timeLeft).pad_decimals(2)

func nextImage():
	stateImages[stateImages.size() - (howManyStatesTillEnd+2)].visible = false
	stateImages[stateImages.size() - (howManyStatesTillEnd+1)].visible = true

func _on_timer_timeout():
	timeout.emit()
