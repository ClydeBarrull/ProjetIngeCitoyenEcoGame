extends Node2D

class_name FailureMessage

signal Closed

@onready var timerPlaceholder : Label = $TimerPlaceholder
@onready var timer : Timer = $Timeout

@export var Timeout : float = 10

var locked : bool = true

func _process(delta):
	if locked :
		timerPlaceholder.text = str(timer.time_left)

func ShowMessage():
	timer.wait_time = Timeout
	timer.start()
	timerPlaceholder.visible = true
	self.visible = true

func CloseMessage():
	Closed.emit()
	HideMessage()

func HideMessage():
	self.visible = false

func _on_button_pressed():
	if !locked :
		CloseMessage()

func _on_timeout_timeout():
	locked = false
	timerPlaceholder.visible = false
