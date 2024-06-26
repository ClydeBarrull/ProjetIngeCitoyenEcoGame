extends Node

class_name MinigamePlayer

signal LeaveToMainMenu

const READERSCENEFILEPATH = "res://scenes/success_messages_reader.tscn"

@onready var leafCurtain : LeafCurtain = $LeafCurtain

var reader : SuccessMessageReader

var playlist : Array = []
var endMessages : Array = []

var currentMinigame : Minigame
var	currentMinigameIndex : int

# TEMP FOR STANDALONE LAUNCH
func _ready():
	leafCurtain.Hiding.connect(Next)
	LoadMinigamePack(self.get_child(0))
	StartPlaying()

func LoadMinigamePack(pack:MinigamePack):
	playlist = pack.playlist
	pack.queue_free()
	
func LoadMinigame(name:String):
	currentMinigame = Utilities.CreateInstance(name,self)
	endMessages.append(currentMinigame.Success.scene_file_path)
	currentMinigame.MinigameCompleted.connect(EndOrTransition)
	currentMinigame.Play()
	
func StartPlaying():
	currentMinigameIndex = 0
	LoadMinigame(playlist[currentMinigameIndex])

func EndOrTransition():
	if (playlist.size() > currentMinigameIndex + 1):
		leafCurtain.play()
	else :
		GameOver()

func Next():
	currentMinigameIndex += 1
	
	if (currentMinigameIndex != 0):
		currentMinigame.MinigameCompleted.disconnect(EndOrTransition)
		currentMinigame.queue_free()
	
	LoadMinigame(playlist[currentMinigameIndex])
	
func GameOver():
	currentMinigame.queue_free()
	reader = Utilities.CreateInstance(READERSCENEFILEPATH,self,[endMessages])
	reader.DoneReading.connect(CloseReader)
	
func CloseReader():
	reader.DoneReading.disconnect(CloseReader)
	reader.queue_free()
	LeaveToMainMenu.emit()
	
