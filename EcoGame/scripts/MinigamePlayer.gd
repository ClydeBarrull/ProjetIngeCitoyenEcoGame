extends Node

class_name MinigamePlayer

signal LeaveToMainMenu

const READERSCENEFILEPATH = "res://scenes/success_messages_reader.tscn"

var reader : SuccessMessageReader

var playlist : Array = []
var endMessages : Array = []

var currentMinigame : Minigame
var	currentMinigameIndex : int

# TEMP FOR STANDALONE LAUNCH
func _ready():
	print("MinigamePlayer ready")
	LoadMinigamePack(self.get_child(0))
	StartPlaying()

func LoadMinigamePack(pack:MinigamePack):
	playlist = pack.playlist
	pack.queue_free()
	
func LoadMinigame(name:String):
	currentMinigame = Utilities.CreateInstance(name,self)
	currentMinigame.MinigameCompleted.connect(Next)
	currentMinigame.Play()
	
func StartPlaying():
	currentMinigameIndex = 0
	LoadMinigame(playlist[currentMinigameIndex])

func Next():
	currentMinigameIndex += 1
	
	if (currentMinigameIndex != 0):
		endMessages.append(currentMinigame.Success.scene_file_path)
		currentMinigame.MinigameCompleted.disconnect(Next)
		currentMinigame.queue_free()
	
	if (playlist.size() > currentMinigameIndex):
		LoadMinigame(playlist[currentMinigameIndex])
	else :
		GameOver()
	
func GameOver():
	currentMinigame.queue_free()
	print("Game over ! time to read !")
	reader = Utilities.CreateInstance(READERSCENEFILEPATH,self,[endMessages])
	reader.DoneReading.connect(CloseReader)
	
func CloseReader():
	reader.DoneReading.disconnect(CloseReader)
	reader.queue_free()
	LeaveToMainMenu.emit()
	
