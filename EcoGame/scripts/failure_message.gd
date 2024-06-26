extends Node2D

class_name FailureMessage

signal Closed

@onready var closeButton : TextureButton = $CloseButton
@onready var timer : Timer = $Timeout

@export var Timeout : float = 2

var locked : bool = true

func _ready():
	HideMessage()

func ShowMessage():
	timer.wait_time = Timeout
	timer.start()
	self.visible = true

func HideMessage():
	self.visible = false

func CloseMessage():
	if !locked :
		Closed.emit()
		HideMessage()

func _on_close_button_pressed():
	if !locked :
		CloseMessage()

func _on_timeout_timeout():
	locked = false
	closeButton.visible = true
