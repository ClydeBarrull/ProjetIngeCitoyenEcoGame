extends Node2D

class_name SuccessMessage

func _ready():
	HideMessage()

func ShowMessage():
	self.visible = true;
	
func HideMessage():
	self.visible = false;
