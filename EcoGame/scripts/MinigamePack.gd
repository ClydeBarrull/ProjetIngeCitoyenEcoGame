extends Node

class_name MinigamePack

var playlist : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	playlist = consumeNodes(self.get_children())
	print(playlist)

func consumeNodes(childrenList:Array) -> Array:
	var consumedNodes = []
	
	for children in childrenList :
		
		if (is_instance_of(children,Minigame)) :
			children = children as Minigame
			consumedNodes.append(children.scene_file_path)
			children.queue_free()
			
		if (is_instance_of(children,MinigamePack)) :
			children = children as MinigamePack
			consumedNodes += children.playlist
			children.queue_free()
			
		else :
			children.queue_free()
	
	if (consumedNodes.is_empty()) : print("Minigame pack is empty !")
	
	return consumedNodes
