extends Node2D

class_name SuccessMessageReader

signal DoneReading

@onready var NextButton : Button = $Next
@onready var PreviousButton : Button = $Previous
@onready var CloseButton : Button = $Close

var currentMessage : SuccessMessage

var playlist : Array = []
var playlistIndex : int

func set_values(endMessages:Array):
	playlist = endMessages
	
func _ready():
	playlistIndex = 0
	LoadMessage()
	
func LoadMessage():
	if (currentMessage != null) :
		currentMessage.queue_free()
	
	currentMessage = Utilities.CreateInstance(playlist[playlistIndex],self)
	
	RefreshButtonsStates()

func RefreshButtonsStates():
	PreviousButton.disabled = (playlistIndex == 0)
	NextButton.disabled = (playlistIndex == playlist.size() - 1)
	CloseButton.disabled = (CloseButton.disabled and !(playlistIndex == playlist.size() - 1))

func _on_next_pressed():
	if (playlistIndex < playlist.size() - 1) :
		playlistIndex += 1
		LoadMessage()

func _on_previous_pressed():
	if (playlistIndex > 0) :
		playlistIndex -= 1
		LoadMessage()

func _on_close_pressed():
	DoneReading.emit()
